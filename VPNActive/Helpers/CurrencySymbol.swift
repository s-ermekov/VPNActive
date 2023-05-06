//
//  CurrencySymbol.swift
//  VPNActive
//
//  Created by Санжар Эрмеков on 06.05.2023.
//

import Foundation

private let currencySymbols: [String: String] = [
    "USD": "$", "AUD": "$", "NZD": "$", "SGD": "$", "HKD": "$", "MXN": "$", "CAD": "$",
    "EUR": "€", "CYP": "€", "AND": "€", "AUT": "€", "BEL": "€", "EST": "€", "FIN": "€", "FRA": "€",
    "DEU": "€", "GRC": "€", "IRL": "€", "ITA": "€", "XKX": "€", "LVA": "€", "LTU": "€", "LUX": "€",
    "MLT": "€", "MCO": "€", "MNE": "€", "NLD": "€", "PRT": "€", "SMR": "€", "SVK": "€", "SVN": "€",
    "ESP": "€", "VAT": "€", "JPY": "¥", "GBP": "£", "CHF": "Fr", "LIE": "Fr", "CNY": "¥", "SEK": "kr",
    "NOK": "kr", "KRW": "₩", "TRY": "₺", "INR": "₹", "RUB": "₽", "BRL": "R$", "ZAR": "R", "PLN": "zł",
    "ALL": "L", "AMD": "֏", "AZN": "₼", "BYN": "Br", "BAM": "KM", "BGN": "лв", "HRK": "kn", "CZK": "Kč",
    "DKK": "kr", "GEL": "₾", "HUF": "Ft", "ISK": "kr", "KZT": "₸", "MKD": "ден", "MDL": "L", "RON": "lei",
    "RSD": "дин.", "UAH": "₴", "AFN": "؋", "BHD": ".د.ب", "BDT": "৳", "BTN": "Nu.", "BND": "$", "KHR": "៛",
    "IDR": "Rp", "IRR": "﷼", "IQD": "ع.د", "ILS": "₪", "JOD": "₪", "KWD": "د.ك", "KGS": "сом", "LAK": "₭",
    "LBP": "ل.ل", "MYR": "RM", "MVR": "ރ.", "MNT": "₮", "MMK": "K", "NPR": "रू", "KPW": "₩", "OMR": "ر.ع.",
    "PKR": "₨", "PHP": "₱", "QAR": "ر.ق", "SAR": "ر.س", "LKR": "රු", "SYP": "£", "TWD": "NT$", "TJS": "ЅМ",
    "THB": "฿", "TMT": "m", "AED": "د.إ", "UZS": "сўм", "VND": "₫", "YER": "﷼", "DZD": "د.ج", "AOA": "Kz", "XOF": "CFA", "BWP": "P", "BIF": "FBu",
    "CVE": "Esc", "XAF": "FCFA", "KMF": "CF", "CDF": "FC", "DJF": "Fdj", "EGP": "£", "ERN": "Nfk",
    "SZL": "E", "ETB": "Br", "GMD": "D", "GHS": "₵", "GNF": "FG", "KES": "KSh", "LSL": "L", "LRD": "$",
    "LYD": "LD", "MGA": "Ar", "MWK": "MK", "MRO": "UM", "MUR": "₨", "MAD": "د.م.", "MZN": "MT", "NAD": "$",
    "NGN": "₦", "RWF": "FRw", "STN": "Db", "SCR": "₨", "SLL": "Le", "SOS": "Sh", "SSP": "£", "SDG": "£",
    "TZS": "TSh", "TND": "د.ت", "UGX": "USh", "ZMW": "ZK", "ARS": "$", "BOB": "Bs.", "CLP": "$", "COP": "$",
    "CRC": "₡", "CUC": "$", "CUP": "$", "DOP": "RD$", "FKP": "£", "GYD": "$", "PYG": "₲", "PEN": "S/.",
    "SRD": "$", "TTD": "TT$", "UYU": "$U", "VES": "Bs.", "BBD": "$", "BZD": "BZ$", "HTG": "G", "JMD": "J$",
    "NIO": "C$", "PAB": "B/.", "USN": "$", "USS": "$"
]

extension String {
    var symbol: String {
        return currencySymbols[self] ?? self
    }
}
