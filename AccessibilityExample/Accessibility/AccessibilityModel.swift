//
//  AccessibilityModel.swift
//  AccessibilityExample
//
//  Created by Daniel Slone on 27/8/21.
//

protocol AccessibilityModel: Equatable {
    var accessibilityValue: String { get }
    var accessibilityLabel: String { get }
}
