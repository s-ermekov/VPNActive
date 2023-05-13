//
//  ContentView.swift
//  VPNActive
//
//  Created by Санжар Эрмеков on 30.04.

import SwiftUI
import NetworkExtension

struct ContentView: View {
    var body: some View {
        MainView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ViewModel())
    }
}