//
//  TransportCell.swift
//  CxjParallaxScrollCollectionExample
//
//  Created by Nikita Begletskiy on 16/03/2025.
//

import UIKit
import CxjParallaxScrollCollection

final class TransportCell: BounceOnTouchCollectionViewCell, CxjParallaxScrollCollection.ContentCell {
	private let label = UILabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		contentView.layer.cornerRadius = 12
		contentView.layer.borderWidth = 1
		
		contentView.addSubview(label)
		
		label.textAlignment = .center
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
		guard let cellModel = cellModel as? TransportCellModel else { return }
		
		configureFor(model: cellModel)
	}
	
	func configureFor(model: TransportCellModel) {
		label.font = model.titleFont
		label.text = model.titleRepresentation
		contentView.backgroundColor = model.backgroundColor
		label.textColor = model.titleColor
	}
}
