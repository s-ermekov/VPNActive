//
//  ViewModel.swift
//  VPNActive
//
//  Created by Санжар Эрмеков on 04.05.2023.
//

import Foundation
import SwiftUI
import MapKit

@MainActor
class ViewModel: ObservableObject {
    @Published var vpnStatus = "N/A"
    @Published var isLoading = false
    @Published var ipData: Model? = nil
    @Published var coordinate: CLLocationCoordinate2D = .init(latitude: 0.0, longitude: 0.0)
    @Published var region: MKCoordinateRegion = .init(
        center: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0),
        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.015)
    )
    
    func updateData() {
        if !isLoading {
            Task {
                self.vpnStatus = VpnChecker.isVpnActive() ? "ON" : "OFF"
//                mockData()
                await fetchIpData()
            }
        } else {
            print("Data is loading... Be patient.")
        }
        
    }
    
    func updateRegion() {
        if let lat = ipData?.latitude, let lon = ipData?.longitude {
            self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            withAnimation {
                self.region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.015))
            }
        }
    }
    
    private func mockData() {
        self.isLoading = true
        if let bishkekData = Model.getBishkekData() {
            self.ipData = bishkekData
            self.updateRegion()
        }
        self.isLoading = false
    }
    
    private func fetchIpData() async {
        self.isLoading = true
        do {
            guard let geodataUrl = URL(string: "https://ipapi.co/json") else { return }
            let (geodata, _) = try await URLSession.shared.data(from: geodataUrl)
            let decoded = try JSONDecoder().decode(Model.self, from: geodata)
            self.ipData = decoded
            self.updateRegion()
        } catch {
            print("DEBUG: Error catched during fetching IP geo data.")
            print(error)
        }
        self.isLoading = false
    }
}
