//
//  FoodiesViewController.swift
//  CxjParallaxScrollCollectionExample
//
//  Created by Nikita Begletskiy on 17/03/2025.
//

import UIKit
import CxjParallaxScrollCollection

final class FoodiesViewController: UIViewController {
	typealias CellModel = any FoodiesCellModel
	
	private let closeButton = UIButton(type: .system)
	private let itemsVCPlaceholderView: UIView = .init()
	
	private lazy var itemsVC: CxjParallaxScrollCollection.ViewController = {
		CxjParallaxViewControllerAssembler.vcWith(
			layout: .init(
				sectionHeight: 40,
				interSectionSpacing: 10,
				interItemSpacing: 8,
				sectionInset: .init(top: 0, left: 16, bottom: 0, right: 16)
			),
			dataSource: self,
			delegate: self
		)
	}()

	private lazy var dataSets: [[CellModel]] = getInitialData()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .white
		setupItemsCollection()
		setupCloseButton()
	}
	
	func setupItemsCollection() {
		view.addSubview(itemsVCPlaceholderView)
		itemsVCPlaceholderView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			itemsVCPlaceholderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			itemsVCPlaceholderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
			itemsVCPlaceholderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			itemsVCPlaceholderView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
		
		setupChildViaConstraints(itemsVC, to: itemsVCPlaceholderView)
	}
	
	func setupCloseButton() {
		closeButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
		closeButton.setTitleColor(.systemRed, for: .normal)
		closeButton.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
		view.addSubview(closeButton)
		closeButton.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
			closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
			closeButton.heightAnchor.constraint(equalToConstant: 30)
		])
	}
	
	// MARK: - Actions
	@objc private func didTapClose() {
		dismiss(animated: true)
	}
}

extension FoodiesViewController: CxjParallaxScrollCollection.DataSource {
	var cellType: any CxjParallaxScrollCollection.ContentCell.Type { FoodiesCell.self }

	func numberOfSections() -> Int { dataSets.count }

	func numberOfItemsInSection(_ sectionIndex: Int) -> Int {
		dataSets[sectionIndex].count
	}

	func cellModelForIndexPath(_ indexPath: IndexPath) -> any CxjParallaxScrollCollection.CellModel {
		dataSets[indexPath.section][indexPath.row]
	}
}

extension FoodiesViewController: CxjParallaxScrollCollection.Delegate {
	func didSelectModelAtIndexPath(_ indexPath: IndexPath) {
		dataSets[indexPath.section][indexPath.item].isSelected.toggle()
		itemsVC.reconfigureItemAtIndexPath(indexPath)
	}
}

private extension FoodiesViewController {
	func getInitialData() -> [[CellModel]] {
		[
			[
				FoodCellModel(title: "Pizza", emoji: "🍕"),
				FoodCellModel(title: "Burger", emoji: "🍔"),
				FoodCellModel(title: "Fries", emoji: "🍟"),
				FoodCellModel(title: "Ice Cream", emoji: "🍨"),
				FoodCellModel(title: "Sushi", emoji: "🍣"),
				FoodCellModel(title: "Hot Dog", emoji: "🌭"),
				FoodCellModel(title: "Taco", emoji: "🌮")
			],
			[
				DrinkCellModel(title: "Coffee", emoji: "☕️"),
				DrinkCellModel(title: "Juice", emoji: "🧃"),
				DrinkCellModel(title: "Soda", emoji: "🥤"),
				DrinkCellModel(title: "Tea", emoji: "🍵"),
				DrinkCellModel(title: "Smoothie", emoji: "🥭"),
			],
			[
				DrinkCellModel(title: "Wine", emoji: "🍷"),
				DrinkCellModel(title: "Cocktail", emoji: "🍹"),
				DrinkCellModel(title: "Beer", emoji: "🍺")
			]
		]
	}
}
