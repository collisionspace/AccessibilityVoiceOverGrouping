//
//  People.swift
//  AccessibilityExample
//
//  Created by Daniel Slone on 27/8/21.
//

import UIKit.UIColor

struct People {
    let name: String
    let age: Int
    let favoriteColor: UIColor

    var accessiblityType: AccessibilityType {
        AccessibilityType(
            accessibilityValue: name + " Age: \(age)",
            accessibilityLabel: "People"
        )
    }
}

extension Array where Element == People {

    static let peoples: [People] =  [
        People(name: "Matt Sando", age: 99, favoriteColor: .purple),
        People(name: "Kate Black", age: 19, favoriteColor: .green),
        People(name: "Alexei Pop", age: 84, favoriteColor: .blue),
        People(name: "Sarah Smith", age: 25, favoriteColor: .red),
        People(name: "Jill Doyle", age: 45, favoriteColor: .gray),
        People(name: "Jo Rice", age: 42, favoriteColor: .systemPink),
        People(name: "Derek Armstrong", age: 78, favoriteColor: .orange),
        People(name: "James Moore", age: 115, favoriteColor: .cyan),
        People(name: "Andrew Mac", age: 5, favoriteColor: .yellow)
    ]
}
