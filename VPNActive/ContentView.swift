//
//  ContentView.swift
//  VPNActive
//
//  Created by Санжар Эрмеков on 30.04.

import SwiftUI
import NetworkExtension

struct HomeView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        VStack (alignment: .leading) {
            if let geoData = viewModel.geoData {
                VStack (spacing: 12) {
                    Text("VPN status: \(viewModel.vpnStatus ? "ON" : "OFF")")
                    Text("Global IP: \(geoData.ip)")
                    Text("Country: \(geoData.country_name)")
                    Text("Coordinate: \(geoData.latitude), \(geoData.longitude)")
                    Button("Update") { viewModel.updateData() }
                        .buttonStyle(.bordered)
                }
            } else {
                VStack (spacing: 12) {
                    Text("VPN status: N/A")
                    Text("Global IP: N/A")
                    Button("Update") { viewModel.updateData() }
                        .buttonStyle(.bordered)
                }
            }
        }
        .padding()
        .onAppear(perform: viewModel.updateData)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ViewModel())
    }
}
