//
//  DrinkCellModel.swift
//  CxjParallaxScrollCollectionExample
//
//  Created by Nikita Begletskiy on 17/03/2025.
//

import UIKit

final class DrinkCellModel: FoodiesCellModel {
	static func == (lhs: DrinkCellModel, rhs: DrinkCellModel) -> Bool { lhs.id == rhs.id }
	func hash(into hasher: inout Hasher) { hasher.combine(id) }

	let id: UUID = UUID()
	let name: String
	let emoji: String
	var isSelected: Bool = false
	
	var title: String {
		emoji + " " + name
	}

	init(title: String, emoji: String, isSelected: Bool = false) {
		self.name = title
		self.emoji = emoji
		self.isSelected = isSelected
	}
	
	var titleFont: UIFont { .systemFont(ofSize: 13, weight: .medium) }
	
	var backgroundColor: UIColor {
		isSelected ? .systemTeal : .systemTeal.withAlphaComponent(0.1)
	}
	
	var textColor: UIColor {
		isSelected ? .white : .systemTeal
	}

	var requiredWidth: CGFloat {
		let width = title.size(withAttributes: [.font: titleFont]).width + 24
		return max(60, width)
	}
}
