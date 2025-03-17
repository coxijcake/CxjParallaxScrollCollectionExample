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
	private let borderView = UIView()
	
	override var scaleOnTouch: CGFloat { 0.95 }
	override var alphaOnTouch: CGFloat { 0.95 }
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		borderView.layer.masksToBounds = true
		borderView.layer.cornerRadius = 14
		borderView.layer.borderWidth = 1
		borderView.isUserInteractionEnabled = false
		
		label.textAlignment = .center
		[borderView, label].forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
			contentView.addSubview($0)
		}
		
		NSLayoutConstraint.activate([
			label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
			label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
			label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
			label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
			
			borderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			borderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			borderView.topAnchor.constraint(equalTo: contentView.topAnchor),
			borderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
		])
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	func configureWithModel(_ cellModel: any CxjParallaxScrollCollection.CellModel) {
		guard let model = cellModel as? HashtagCellModel else { return }
		
		label.text = model.title
		label.font = model.titleFont
		borderView.backgroundColor = model.backgroundColor
		borderView.layer.borderColor = model.borderColor.cgColor
		borderView.transform = model.isSelected ? .identity : .init(scaleX: 0.85, y: 0.85)
		label.textColor = model.textColor
	}
}
