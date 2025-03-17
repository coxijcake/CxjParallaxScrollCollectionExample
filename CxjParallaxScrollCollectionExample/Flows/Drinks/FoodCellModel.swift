//
//  FoodCellModel.swift
//  CxjParallaxScrollCollectionExample
//
//  Created by Nikita Begletskiy on 17/03/2025.
//

import UIKit

final class FoodCellModel: FoodiesCellModel {
	static func == (lhs: FoodCellModel, rhs: FoodCellModel) -> Bool { lhs.id == rhs.id }
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
		isSelected ? .systemOrange : .systemOrange.withAlphaComponent(0.1)
	}
	
	var textColor: UIColor {
		isSelected ? .white : .systemOrange
	}

	var requiredWidth: CGFloat {
		let width = title.size(withAttributes: [.font: titleFont]).width + 24
		return max(60, width)
	}
}
