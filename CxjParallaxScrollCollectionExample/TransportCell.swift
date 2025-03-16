//
//  TransportCell.swift
//  CxjParallaxScrollCollectionExample
//
//  Created by Nikita Begletskiy on 16/03/2025.
//

import UIKit
import CxjParallaxScrollCollection

final class TransportCell: BounceOnTouchCollectionViewCell, CxjParallaxScrollCollection.ContentCell {
	static var titleFont: UIFont { .systemFont(ofSize: 12, weight: .medium) }
	
	override var scaleOnTouch: CGFloat { 0.95 }
	override var alphaOnTouch: CGFloat { 0.95 }
	
	private let label = UILabel()

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		contentView.layer.cornerRadius = contentView.bounds.size.height * 0.5
	}
	
	private func setupViews() {
		label.textAlignment = .center
		label.font = Self.titleFont
		
		contentView.addSubview(label)
		
		label.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			label.topAnchor.constraint(equalTo: contentView.topAnchor),
			label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
		])
		
		contentView.layer.masksToBounds = true
		contentView.backgroundColor = .gray
	}
	
	func configureWithModel(_ cellModel: any CxjParallaxScrollCollection.CellModel) {
		guard let cellModel = cellModel as? TransportCellModel else { return }
		
		label.text = cellModel.title
		contentView.backgroundColor = cellModel.isSelected ? .lightGray : .gray
	}
}
