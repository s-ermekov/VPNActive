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
}

extension Model {
    static func getBishkekData() -> Model? {
        guard let url = Bundle.main.url(forResource: "bishkek", withExtension: "json"), let data = try? Data(contentsOf: url) else {  return nil }
        do {
            let bishkekData = try JSONDecoder().decode(Model.self, from: data)
            return bishkekData
        } catch {
            print("Error decoding JSON: \(error)")
        }
        return nil
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
