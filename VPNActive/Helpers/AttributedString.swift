//
//  AttributedString.swift
//  VPNActive
//
//  Created by Санжар Эрмеков on 12.05.2023.
//

import Foundation
import SwiftUI

extension AttributedString {
    var light: AttributedString {
        var container = AttributeContainer()
        container[AttributeScopes.SwiftUIAttributes.FontAttribute.self] = .body.weight(.light)
        return self.mergingAttributes(container, mergePolicy: .keepNew)
    }
    var medium: AttributedString {
        var container = AttributeContainer()
        container[AttributeScopes.SwiftUIAttributes.FontAttribute.self] = .body.weight(.medium)
        return self.mergingAttributes(container, mergePolicy: .keepNew)
    }
    var semibold: AttributedString {
        var container = AttributeContainer()
        container[AttributeScopes.SwiftUIAttributes.FontAttribute.self] = .body.weight(.semibold)
        return self.mergingAttributes(container, mergePolicy: .keepNew)
    }
    var thin: AttributedString {
        var container = AttributeContainer()
        container[AttributeScopes.SwiftUIAttributes.FontAttribute.self] = .body.weight(.thin)
        return self.mergingAttributes(container, mergePolicy: .keepNew)
    }
    var ultralight: AttributedString {
        var container = AttributeContainer()
        container[AttributeScopes.SwiftUIAttributes.FontAttribute.self] = .body.weight(.ultraLight)
        return self.mergingAttributes(container, mergePolicy: .keepNew)
    }
    
    init(_ string: String, font: Font) {
        var container = AttributeContainer()
        container[AttributeScopes.SwiftUIAttributes.FontAttribute.self] = font
        self.init(string, attributes: container)
    }
}
