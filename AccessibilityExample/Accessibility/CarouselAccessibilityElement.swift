//
//  CarouselAccessibilityElement.swift
//  AccessibilityExample
//
//  Created by Daniel Slone on 27/8/21.
//

import Foundation
import UIKit

/***
 CarouselAccessibilityElement allows for swiping back and forth through the CollectionView and selecting of current item.

 For further information please refer to `CarouselA11y.md` or below

 Based this on this sample code and video
 code -  https://developer.apple.com/documentation/accessibility/delivering_an_exceptional_accessibility_experience
 video - https://developer.apple.com/videos/play/wwdc2018/230/
 */
final class CarouselAccessibilityElement<T: CarouselAccessibilityView, U: AccessibilityModel>: UIAccessibilityElement {

    private enum Direction: Int {
        case forward = 1
        case backward = -1

        static func accessiblityDirection(_ direction: UIAccessibilityScrollDirection) -> Direction? {
            switch direction {
            case .left:
                return .forward
            case .right:
                return .backward
            default:
                return nil
            }
        }
    }

    var currentElement: U?

    @CapNumber
    private(set) var currentIndex: Int = 0

    private var totalCount: Int {
        guard let containerView = accessibilityContainer as? T,
              let elements = containerView.items as? [U] else {
            return 0
        }
        return elements.count
    }

    init(accessibilityContainer: T, currentElement: U?) {
        super.init(accessibilityContainer: accessibilityContainer)
        self.currentElement = currentElement
        self._currentIndex.configure(
            min: 0,
            max: totalCount - 1
        )
    }

    override func accessibilityActivate() -> Bool {
        guard let containerView = accessibilityContainer as? T else {
            return false
        }

        containerView.didSelectItemAt(
            IndexPath(item: currentIndex, section: 0)
        )
        return true
    }

    /// This indicates to the user what exactly this element is supposed to be.
    override var accessibilityLabel: String? {
        get {
            guard let value = currentElement?.accessibilityLabel else {
                return super.accessibilityLabel
            }

            return value
        }
        set {
            super.accessibilityLabel = newValue
        }
    }

    override var accessibilityValue: String? {
        get {
            if let value = currentElement?.accessibilityValue {
                return value + "\(currentIndex + 1) of \(totalCount)"
            }

            return super.accessibilityValue
        }
        set {
            super.accessibilityValue = newValue
        }
    }

    // This tells VoiceOver that our element will support the increment and decrement callbacks.
    /// - Tag: accessibility_traits
    override var accessibilityTraits: UIAccessibilityTraits {
        get {
            return .adjustable
        }
        set {
            super.accessibilityTraits = newValue
        }
    }

    // MARK: Accessibility

    /*
        Overriding the following two methods allows the user to perform increment and decrement actions
        (done by swiping up or down).
    */
    /// - Tag: accessibility_increment_decrement
    override func accessibilityIncrement() {
        // This causes the picker to move forward one if the user swipes up.
        accessibilityScroll(.forward)
    }

    override func accessibilityDecrement() {
        // This causes the picker to move back one if the user swipes down.
        accessibilityScroll(.backward)
    }

    /*
        This will cause the picker to move forward or backwards on when the user does a 3-finger swipe,
        depending on the direction of the swipe. The return value indicates whether or not the scroll was successful,
        so that VoiceOver can alert the user if it was not.
    */
    override func accessibilityScroll(_ direction: UIAccessibilityScrollDirection) -> Bool {
        guard let direction = Direction.accessiblityDirection(direction) else {
            return false
        }
        return accessibilityScroll(direction)
    }

    /**
        A convenience for scrollinig `forwards` or `backwards`
        It returns a `Bool` because `accessibilityScroll` needs to know if the scroll was successful.
    */
    @discardableResult
    private func accessibilityScroll(_ direction: Direction) -> Bool {
        guard let currentElement = currentElement,
              let containerView = accessibilityContainer as? T,
              let elements = containerView.items as? [U],
              let index = elements.firstIndex(of: currentElement),
              index > 0 || index < elements.count - 1 else {
            return false
        }

        currentIndex = index + direction.rawValue

        let indexPath = IndexPath(row: currentIndex, section: 0)

        containerView.focusOnItem(at: indexPath)

        // Scroll the collection view to the currently focused item
        containerView.collectionView.scrollToItem(
            at: indexPath,
            at: .centeredHorizontally,
            animated: true
        )

        return true
    }
}
