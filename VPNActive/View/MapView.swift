//
//  MapView.swift
//  VPNActive
//
//  Created by Санжар Эрмеков on 06.05.2023.
//

import SwiftUI
import MapKit

extension CLLocationCoordinate2D: Identifiable {
    public var id: String { return UUID().uuidString }
}

struct MapView: View {
    @EnvironmentObject var vm: ViewModel
    @Environment(\.dismiss) var dismiss
    
    private var mkRegion: Binding<MKCoordinateRegion> {
        Binding( get: { vm.region }, set: { _ in })
    }
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: mkRegion, annotationItems: [vm.coordinate]) { coordinate in
                MapMarker(coordinate: coordinate)
            }
            .ignoresSafeArea()
            .navigationBarBackButtonHidden()
            
            VStack {
                Spacer()
                HStack(spacing: 16) {
                    Spacer()
                    Button {
                        vm.updateRegion()
                    } label: {
                        Image(systemName: "location.fill")
                            .foregroundColor(Color.accentRed)
                            .frame(width: 48, height: 48)
                            .background(.gray.opacity(0.75))
                            .cornerRadius(8)
                    }
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(Color.accentRed)
                            .frame(width: 48, height: 48)
                            .background(.gray.opacity(0.75))
                            .cornerRadius(8)
                    }
                }
            }
            .padding()
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .environmentObject(ViewModel())
    }
}
