//
//  FoodiesCell.swift
//  CxjParallaxScrollCollectionExample
//
//  Created by Nikita Begletskiy on 17/03/2025.
//

import UIKit
import CxjParallaxScrollCollection

// MARK: - DrinkCell
final class FoodiesCell: BounceOnTouchCollectionViewCell, CxjParallaxScrollCollection.ContentCell {
	private let label = UILabel()
	
	override var scaleOnTouch: CGFloat { 0.95 }
	override var alphaOnTouch: CGFloat { 0.975 }
	
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
		guard let model = cellModel as? (any FoodiesCellModel) else { return }
		
		label.text = model.title
		label.font = model.titleFont
		label.textColor = model.textColor
		contentView.backgroundColor = model.backgroundColor
	}
}
