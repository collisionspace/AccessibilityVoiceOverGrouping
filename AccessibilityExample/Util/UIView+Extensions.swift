//
//  UIView+Extensions.swift
//  AccessibilityExample
//
//  Created by Daniel Slone on 27/8/21.
//

import UIKit

extension UIView {

    func constraintToSuperview() {
        guard let superview = superview else {
            preconditionFailure("View doesn't have superview: \(self)")
        }
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            topAnchor.constraint(equalTo: superview.topAnchor)
        ])
    }
}
