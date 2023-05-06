//
//  VPNActiveApp.swift
//  VPNActive
//
//  Created by Санжар Эрмеков on 30.04.2023.
//

import SwiftUI

@main
struct VPNActiveApp: App {
    @StateObject var viewModel: ViewModel = .init()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
