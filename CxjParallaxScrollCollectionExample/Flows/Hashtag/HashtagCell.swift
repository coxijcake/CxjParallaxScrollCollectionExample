//
//  HashtagCell.swift
//  CxjParallaxScrollCollectionExample
//
//  Created by Nikita Begletskiy on 17/03/2025.
//

import UIKit
import CxjParallaxScrollCollection

final class HashtagCell: BounceOnTouchCollectionViewCell, CxjParallaxScrollCollection.ContentCell {
	private let label = UILabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		contentView.layer.cornerRadius = 14
		contentView.layer.borderWidth = 1
		
		label.textAlignment = .center
		contentView.addSubview(label)
		label.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			label.topAnchor.constraint(equalTo: contentView.topAnchor),
			label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
		])
	}
	required init?(coder: NSCoder) { fatalError() }
	
	func configureWithModel(_ cellModel: any CxjParallaxScrollCollection.CellModel) {
		guard let model = cellModel as? HashtagCellModel else { return }
		
		label.text = model.title
		label.font = model.titleFont
		contentView.backgroundColor = model.backgroundColor
		contentView.layer.borderColor = model.borderColor.cgColor
		label.textColor = model.textColor
	}
}
