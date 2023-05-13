//
//  Model.swift
//  VPNActive
//
//  Created by Санжар Эрмеков on 03.05.2023.
//

import Foundation
import CoreLocation

struct Model: Decodable {
    let ip: String?
    let city: String?
    let region: String?
    let region_code: String?
    let country: String?
    let country_name: String?
    let country_code: String?
    let country_capital: String?
    let country_tld: String?
    let postal: String?
    let latitude: Double?
    let longitude: Double?
    let timezone: String?
    let utc_offset: String?
    let country_calling_code: String?
    let currency: String?
    let currency_name: String?
    let asn: String?
    let org: String?
    
    var utc: String? {
        if let utc_offset {
            let last = utc_offset.lastIndex(of: "0")
            let dotOffset = utc_offset.index(last!, offsetBy: -1)
            var str = utc_offset
            str.insert(":", at: dotOffset)
            return str
        } else {
            return nil
        }
    }
}

extension Model {
    static let bishkek = Model(ip: "193.34.225.69", city: "Bishkek", region: "", region_code: "", country: "KG", country_name: "Kyrgyzstan", country_code: "KG", country_capital: "Bishkek", country_tld: ".kg", postal: nil, latitude: 42.8696, longitude: 74.5932, timezone: "Asia/Bishkek", utc_offset: "+0600", country_calling_code: "+996", currency: "KGS", currency_name: "Som", asn: "AS42837", org: "Extra Line LLC")
    
    static func fetchData(completion: @escaping (Model?, Error?) -> ()) {
        guard let url = URL(string: "https://ipapi.co/json") else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error {
                print("DEBUG: Model Extension. Error of fetching data model. Localized Description: \(error.localizedDescription)")
                completion(nil, error)
            }
            if let data {
                do {
                    let model = try JSONDecoder().decode(Model.self, from: data)
                    completion(model, nil)
                } catch {
                    completion(nil, error)
                }
            }
        }
        .resume()
    }
    
    // Computed properties
    var coordinate: CLLocationCoordinate2D {
        if let lat = latitude, let lon = longitude {
            return CLLocationCoordinate2D(latitude: lat, longitude: lon)
        } else {
            return CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
        }
    }
    
    var formattedCoordinate: String {
        if let lat = latitude, let lon = longitude {
            let fC = "\(String(format: "%.4f", lat)), \(String(format: "%.4f", lon))"
            return fC
        } else {
            return ""
        }
    }
}

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
