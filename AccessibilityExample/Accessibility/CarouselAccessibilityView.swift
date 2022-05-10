//
//  CarouselAccessibilityView.swift
//  AccessibilityExample
//
//  Created by Daniel Slone on 27/8/21.
//

import UIKit

protocol CarouselAccessibilityView {
    associatedtype T: AccessibilityModel
    var currentItem: T? { get }
    var items: [T]? { get }
    var collectionView: UICollectionView { get }
    func focusOnItem(at indexPath: IndexPath)
    func didSelectItemAt(_ indexPath: IndexPath)
}
