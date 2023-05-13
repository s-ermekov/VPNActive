//
//  ViewModel.swift
//  VPNActive
//
//  Created by Санжар Эрмеков on 04.05.2023.
//

import Foundation
import SwiftUI
import MapKit
import WidgetKit

class ViewModel: ObservableObject {
    @Published var vpnStatus = "N/A"
    @Published var isLoading = false
    @Published var ipData: Model? = nil
    @Published var coordinate: CLLocationCoordinate2D = .init(latitude: 0.0, longitude: 0.0)
    @Published var region: MKCoordinateRegion = .init(
        center: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0),
        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.015)
    )
    @Published var toast: Bool = false
    
    func updateData() {
        if !isLoading {
            self.vpnStatus = VPNChecker.vpnActive() ? "ON" : "OFF"
            fetchData()
        } else {
            print("Data is loading... Be patient.")
        }
        
    }
    
    func updateRegion() {
        self.isLoading = true
        if let lat = ipData?.latitude, let lon = ipData?.longitude {
            DispatchQueue.main.async {
                self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                withAnimation {
                    self.region = MKCoordinateRegion(center: self.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.015))
                    self.isLoading = false
                }
            }
        } else {
            self.isLoading = false
        }
    }
    
    private func fetchData() {
        self.isLoading = true
        Model.fetchData { model, error in
            if let error {
                print("DEBUG: View Model. fetchData Error. Localized Description: \(error.localizedDescription).")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.ipData = nil
                    self.isLoading = false
                }
            }
            if let model {
                DispatchQueue.main.async {
                    self.ipData = model
                    self.updateRegion()
                    WidgetCenter.shared.reloadTimelines(ofKind: "VPN Active Widget")
                    self.isLoading = false
                }
            }
        }
        
    }
}
