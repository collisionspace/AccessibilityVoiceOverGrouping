//
//  PeopleCollectionViewCell.swift
//  AccessibilityExample
//
//  Created by Daniel Slone on 27/8/21.
//

import UIKit.UICollectionViewCell

final class PeopleCollectionViewCell: UICollectionViewCell {

    private lazy var title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(title)
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            title.heightAnchor.constraint(equalToConstant: 80),
            title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            title.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: PeopleViewModel) {
        title.attributedText = viewModel.attributedTitle
        contentView.backgroundColor = viewModel.people.favoriteColor
    }
}
