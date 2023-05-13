//
//  Toast.swift
//  VPNActive
//
//  Created by Санжар Эрмеков on 06.05.2023.
//

import SwiftUI

struct Toast: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        Text("\"\(UIPasteboard.general.string ?? "")\" copied to clipboard")
            .foregroundColor(.white)
            .padding(.vertical)
            .frame(width: UIScreen.main.bounds.width - 32)
            .background(Color.themeColor)
            .transition(.move(edge: .top))
            .cornerRadius(10)
            .padding(.top)
            .onAppear {
                let _ = Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
                    withAnimation(.easeIn(duration: 0.2)) {
                        isPresented = false
                    }
                }
            }
    }
}
