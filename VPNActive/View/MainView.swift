//
//  MainView.swift
//  VPNActive
//
//  Created by Санжар Эрмеков on 04.05.2023.
//

import SwiftUI
import MapKit

struct MainView: View {
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            IPView()
            
            VStack {
                if vm.toast {
                    Toast(isPresented: $vm.toast)
                }
                Spacer()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(ViewModel())
    }
}
