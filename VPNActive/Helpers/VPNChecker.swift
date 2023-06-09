//
//  VPNChecker.swift
//  VPNActive
//
//  Created by Санжар Эрмеков on 13.05.2023.
//

import Foundation

struct VPNChecker {
    private static let vpnProtocolsKeysIdentifiers = [
        "tap", "tun", "ppp", "ipsec", "utun"
    ]
    
    static func vpnActive() -> Bool {
        guard let cfDict = CFNetworkCopySystemProxySettings() else { return false }
        let nsDict = cfDict.takeRetainedValue() as NSDictionary
        guard let keys = nsDict["__SCOPED__"] as? NSDictionary,
            let allKeys = keys.allKeys as? [String] else { return false }
        for key in allKeys {
            for protocolId in vpnProtocolsKeysIdentifiers where key.starts(with: protocolId) { return true }
        }
        return false
    }
}
