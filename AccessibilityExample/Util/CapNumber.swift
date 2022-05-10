//
//  CapNumber.swift
//  AccessibilityExample
//
//  Created by Daniel Slone on 27/8/21.
//

/**
 Use when you want to cap a number between a certain range
 There is 2 different ways this can be used:

 The first way is for when you know ahead of time what both min and max is
 and you aren't relying on needing a reference to `self` for these numbers

 @CapNumber(min: 0, max: 20)
 var index: Int


 The second way is for you when you need a reference to `self`

 @CapNumber
 private(set) var currentIndex: Int
 ...
 ...
 _currentIndex.configure(min: .zero, max: Array.count - 1)
 */
@propertyWrapper
final class CapNumber<T: Numeric & Equatable & Comparable> {
    var wrappedValue: T {
        didSet {
            updateWrappedValue()
        }
    }

    private var min: T
    private var max: T

    init(wrappedValue: T = .zero, min: T = .zero, max: T = .zero) {
        self.wrappedValue = wrappedValue
        self.min = min
        self.max = max
    }

    func configure(min: T, max: T) {
        self.min = min
        self.max = max
        updateWrappedValue()
    }

    private func updateWrappedValue() {
        if wrappedValue < min {
            wrappedValue = min
        } else if wrappedValue > max {
            wrappedValue = max
        }
    }
}
