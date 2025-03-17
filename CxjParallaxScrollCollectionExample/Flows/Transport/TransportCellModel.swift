//
//  TransportCellModel.swift
//  CxjParallaxScrollCollectionExample
//
//  Created by Nikita Begletskiy on 16/03/2025.
//

import UIKit
import CxjParallaxScrollCollection

final class TransportCellModel: CxjParallaxScrollCollection.CellModel, Hashable {
	static func == (lhs: TransportCellModel, rhs: TransportCellModel) -> Bool { lhs.id == rhs.id }
	func hash(into hasher: inout Hasher) { hasher.combine(id) }

	let id: UUID = UUID()
	let title: String
	let icon: String
	var isSelected: Bool = false
	
	var titleRepresentation: String {
		(icon + " " + title)
	}

	init(title: String, icon: String, isSelected: Bool = false) {
		self.title = title
		self.icon = icon
		self.isSelected = isSelected
	}
	
	var titleFont: UIFont { .systemFont(ofSize: 12, weight: .medium) }

	var titleColor: UIColor {
		isSelected ? .white : .black
	}
	
	var backgroundColor: UIColor {
		isSelected ? .systemGreen : .systemGreen.withAlphaComponent(0.1)
	}
	
	var requiredWidth: CGFloat {
		let minWidth: CGFloat = 60
		let titleWidth: CGFloat = titleRepresentation.size(withAttributes: [.font: titleFont]).width
		let titleWidthWithPadding: CGFloat = titleWidth + 24
		
		return max(minWidth, titleWidthWithPadding)
	}
}
