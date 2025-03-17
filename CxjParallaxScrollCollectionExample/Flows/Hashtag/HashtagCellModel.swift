//
//  HashtagCellModel.swift
//  CxjParallaxScrollCollectionExample
//
//  Created by Nikita Begletskiy on 17/03/2025.
//

import UIKit
import CxjParallaxScrollCollection

struct HashtagCellModel: CxjParallaxScrollCollection.CellModel {
	private let hashTagText: String = "#"
	
	let name: String
	let isSelected: Bool
	
	var title: String {
		hashTagText + name
	}
	
	var titleFont: UIFont { .systemFont(ofSize: 14, weight: .semibold) }
	
	var backgroundColor: UIColor {
		isSelected ? .systemBlue : .systemBlue.withAlphaComponent(0.1)
	}
	
	var borderColor: UIColor {
		isSelected ? .clear : .systemBlue
	}
	
	var textColor: UIColor {
		isSelected ? .white : .systemBlue
	}

	var requiredWidth: CGFloat {
		let width = title.size(withAttributes: [.font: titleFont]).width + 30
		return max(60, width)
	}
}
