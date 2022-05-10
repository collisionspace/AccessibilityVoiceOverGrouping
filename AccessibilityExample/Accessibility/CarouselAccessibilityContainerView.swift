//
//  CarouselAccessibilityContainerView.swift
//  AccessibilityExample
//
//  Created by Daniel Slone on 27/8/21.
//

import Foundation
import UIKit

typealias CarouselAccessibilityElementType = CarouselAccessibilityElement<CarouselAccessibilityContainerView, AccessibilityType>

/***
 CarouselAccessibilityContainerView is used as a container for the Collection View that allows for grouping voice over.

 For further information please refer to `CarouselA11y.md` or below

 Based this on this sample code and video
 code -  https://developer.apple.com/documentation/accessibility/delivering_an_exceptional_accessibility_experience
 video - https://developer.apple.com/videos/play/wwdc2018/230/
 */
final class CarouselAccessibilityContainerView: UIView, CarouselAccessibilityView {

    let collectionView: UICollectionView

    private let didSelectItemAction: ((IndexPath) -> Void)

    /// Current items in the collection view
    var items: [AccessibilityType]? {
        didSet {
            currentItem = items?.first
        }
    }

    /// Element that allows for swiping through the collection view and also
    /// selecting current item via double tap
    private var carouselAccessibilityElement: CarouselAccessibilityElementType?

    init(collectionView: UICollectionView, didSelectItemAction: @escaping ((IndexPath) -> Void)) {
        self.collectionView = collectionView
        self.didSelectItemAction = didSelectItemAction

        super.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        collectionView.constraintToSuperview()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Tracks the current item that is focused on via the accessibility voice over swiping
    private(set) var currentItem: AccessibilityType? {
        didSet {
            cachedAccessibilityElements = nil

            guard let currentItem = currentItem,
                  let carouselAccessibilityElement = carouselAccessibilityElement else {
                      return
            }
            carouselAccessibilityElement.currentElement = currentItem
        }
    }

    func focusOnItem(at indexPath: IndexPath) {
        guard let item = items?[indexPath.row] else {
            return
        }
        currentItem = item
    }

    func didSelectItemAt(_ indexPath: IndexPath) {
        didSelectItemAction(indexPath)
    }

    /// Needs to be called if in this is inside any cells (Collection/Table)
    func prepareForReuse() {
        currentItem = nil
        items = nil
        carouselAccessibilityElement = nil
        accessibilityElements = nil
    }

    /// - Tag: using_carousel_accessibility_element
    private var cachedAccessibilityElements: [Any]?

    // This will also allow for adding custom accessiblity actions as well
    override var accessibilityElements: [Any]? {
        set {
            cachedAccessibilityElements = newValue
        }
        get {
            guard cachedAccessibilityElements == nil else {
                return cachedAccessibilityElements
            }

            let carouselAccessibilityElement: CarouselAccessibilityElementType
            if let theCarouselAccessibilityElement = self.carouselAccessibilityElement {
                carouselAccessibilityElement = theCarouselAccessibilityElement
            } else if let currentItem = currentItem {
                carouselAccessibilityElement = CarouselAccessibilityElementType(
                    accessibilityContainer: self,
                    currentElement: currentItem
                )

                carouselAccessibilityElement.accessibilityFrameInContainerSpace = collectionView.frame
                self.carouselAccessibilityElement = carouselAccessibilityElement
            } else {
                return cachedAccessibilityElements
            }


            cachedAccessibilityElements = [carouselAccessibilityElement]

            return cachedAccessibilityElements
        }
    }
}
