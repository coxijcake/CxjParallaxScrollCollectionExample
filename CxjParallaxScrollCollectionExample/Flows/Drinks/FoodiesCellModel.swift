//
//  FoodiesCellModel.swift
//  CxjParallaxScrollCollectionExample
//
//  Created by Nikita Begletskiy on 17/03/2025.
//

import UIKit
import CxjParallaxScrollCollection

protocol FoodiesCellModel: CxjParallaxScrollCollection.CellModel, Hashable {
	var title: String { get }
	var titleFont: UIFont { get }
	var backgroundColor: UIColor { get }
	var textColor: UIColor { get }
	var isSelected: Bool { get set }
}
