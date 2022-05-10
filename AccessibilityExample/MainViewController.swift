//
//  MainViewController.swift
//  AccessibilityExample
//
//  Created by Daniel Slone on 27/8/21.
//

import UIKit

final class MainViewController: UIViewController {

    private lazy var carouselContainerView: CarouselAccessibilityContainerView =
        CarouselAccessibilityContainerView(
            collectionView: collectionView
        ) { [weak self] indexPath in
            self?.didSelectItemAt(indexPath)
        }

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
    
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.isPagingEnabled = false
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    private let peoples: [People] =  .peoples

    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
        collectionView.register(
            PeopleCollectionViewCell.self,
            forCellWithReuseIdentifier: "UICollectionViewCell"
        )

        // IMPORTANT
        // Must set the items here for grouping voice over to work
        carouselContainerView.items = peoples.map(\.accessiblityType)
    }

    private func buildLayout() {
        view.addSubview(carouselContainerView)
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 80),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalToSystemSpacingBelow: guide.topAnchor, multiplier: 1.0),
        ])
    }

    private func didSelectItemAt(_ indexPath: IndexPath) {
        print("\(#function) - \(indexPath) selected")
    }
}

extension MainViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(#function) - \(indexPath) selected")
    }
}

extension MainViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        peoples.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath) as! PeopleCollectionViewCell
        cell.configure(with: PeopleViewModel(people: peoples[indexPath.row]))
        return cell
    }
}


import SwiftUI

struct MasterCard: View {
    var body: some View {
        ZStack {
            Image("mastercard")
        }
    }
}
