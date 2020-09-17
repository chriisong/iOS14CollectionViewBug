//
//  CollectionViewCell.swift
//  CollectionViewBug
//
//  Created by Chris Song on 2020-09-17.
//

import UIKit

class CollectionViewBugCell: UICollectionViewCell {
    
    static let reuseIdentifier = "cell-reuse-identifier"
    private var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("not implemented") }

    private func configure() {
        label = UILabel(frame: self.bounds)
        label.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemGray5
        layer.cornerRadius = 16
        clipsToBounds = true
        
        
        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
        label.text = "iOS 14 CollectionView Cell Bug: Overlaps the Navigation Item Search Controller"
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = .label
        
    }
}
