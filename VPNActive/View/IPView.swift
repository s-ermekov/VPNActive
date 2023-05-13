//
//  MyInformation.swift
//  VPNActive
//
//  Created by Санжар Эрмеков on 08.05.2023.
//

import SwiftUI

struct IPView: View {
    @EnvironmentObject var vm: ViewModel
    @Environment(\.dismissSearch) var dismissSearch
    @Environment(\.isSearching) var isSearching
    
    var body: some View {
        NavigationView {
            Form {
                // my IP data is loaded
                if let data = vm.ipData {
                    Section("Is VPN active?") {
                        Text("VPN status: \(vm.vpnStatus)")
                        if let ip = data.ip {
                            IPViewLine(text: "IP: \(ip)", toCopy: ip, toast: $vm.toast)
                        }
                        if let org = data.org {
                            IPViewLine(text: "Organization: \(org)", toCopy: org, toast: $vm.toast)
                        }
                        
                    }
                    Section("Geo Information") {
                        if data.latitude != nil, data.longitude != nil {
                            NavigationLink("Coordinate: \(data.formattedCoordinate)", destination: MapView())
                        }
                        if let city = data.city {
                            IPViewLine(text: "City: \(city)", toCopy: city, toast: $vm.toast)
                        }
                        if let postal = data.postal {
                            IPViewLine(text: "Postal code: \(postal)", toCopy: postal, toast: $vm.toast)
                        }
                        
                        if let timezone = data.timezone, let utc = data.utc {
                            IPViewLine(text: "Timezone: \(timezone) (\(utc))", toCopy: timezone, toast: $vm.toast)
                        }
                    }
                    Section {
                        if let flag = data.country_code, let name = data.country_name {
                            IPViewLine(text: "Country: \(name) | \(flag.emoji)", toCopy: flag.emoji, toast: $vm.toast)
                         }
                        if let capital = data.country_capital {
                            IPViewLine(text: "Capital: \(capital)", toCopy: capital, toast: $vm.toast)
                        }
                        if let currency = data.currency, let currName = data.currency_name {
                            IPViewLine(text: "Currency: \(currName) | \(currency.symbol)", toCopy: currency.symbol, toast: $vm.toast)
                        }
                        if let phoneCode = data.country_calling_code, let tld = data.country_tld {
                            IPViewLine(text: "Phone code: \(phoneCode), Domain: \(tld)", toCopy: phoneCode, toast: $vm.toast)
                        }
                    } header: {
                        Text("Country Information")
                    } footer: {
                        HStack(spacing: 0) {
                            Spacer()
                            Text("Provided by ipapi.co")
                                .italic()
                        }
                    }
                    .transition(.move(edge: .bottom))
                } else {
                    // my IP data wasn't loaded yet
                    Section("Is VPN active?") {
                        Text("VPN connection: \(vm.vpnStatus)")
                            .onAppear { vm.updateData() }
                    }
                }
                Section {
                    Button {
                        vm.updateData()
                    } label: {
                        HStack(alignment: .center, spacing: 10) {
                            Text("Refresh")
                            if vm.isLoading {
                                ProgressView().frame(width: 36, height: 36)
                            }
                            Spacer()
                        }
                    }
                    .disabled(vm.isLoading)
                }
            } // Form End
            .onOpenURL { if $0.description == "vpnactive://update" { vm.updateData() } }
        }
    }
}

struct IPViewLine: View {
    let text: String
    let toCopy: String
    @Binding var toast: Bool
    
    var body: some View {
        HStack(alignment: .bottom) {
            Text(text)
            Spacer()
            Image(systemName: "square.on.square")
                .scaleEffect(0.85)
                .onTapGesture { UIPasteboard.general.string = toCopy
                    withAnimation { toast = true } } }
    }
}

struct MyInformation_Previews: PreviewProvider {
    static var previews: some View {
        IPView()
    }
}
