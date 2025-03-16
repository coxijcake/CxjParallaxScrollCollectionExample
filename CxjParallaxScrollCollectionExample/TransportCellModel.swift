//
//  TransportCellModel.swift
//  CxjParallaxScrollCollectionExample
//
//  Created by Nikita Begletskiy on 16/03/2025.
//

import UIKit
import CxjParallaxScrollCollection

final class TransportCellModel: CxjParallaxScrollCollection.CellModel, Hashable {
	static func == (lhs: TransportCellModel, rhs: TransportCellModel) -> Bool {
		lhs.id == rhs.id
	}
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
	
	let id: UUID = UUID()
	let title: String
	
	var isSelected: Bool = false
	
	init(title: String, isSelected: Bool = false) {
		self.title = title
		self.isSelected = isSelected
	}
	
	var titleFont: UIFont {
		.systemFont(ofSize: 12, weight: .medium)
	}
	
	var requiredWidth: CGFloat {
		let minWidth: CGFloat = 60
		let titleWidth: CGFloat = title.size(withAttributes: [.font: titleFont]).width
		let titleWidthWithPadding: CGFloat = titleWidth + 16
		
		return max(minWidth, titleWidthWithPadding)
	}
}
