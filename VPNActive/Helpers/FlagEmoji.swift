//
//  FlagEmoji.swift
//  VPNActive
//
//  Created by Санжар Эрмеков on 06.05.2023.
//

import Foundation

extension String {
    var emoji: String {
        let base: UInt32 = 127397
        var flag = ""
        
        for scalar in unicodeScalars {
            flag.append(String(UnicodeScalar(base + scalar.value)!))
        }
        
        return flag
    }
}

