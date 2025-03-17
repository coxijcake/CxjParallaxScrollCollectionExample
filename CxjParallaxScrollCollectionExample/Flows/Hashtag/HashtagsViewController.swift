//
//  HashtagsViewController.swift
//  CxjParallaxScrollCollectionExample
//
//  Created by Nikita Begletskiy on 17/03/2025.
//

import UIKit
import CxjParallaxScrollCollection

final class HashtagsViewController: UIViewController {
	private let closeButton = UIButton(type: .system)
	private let hashtagsVCPlaceholderView: UIView = .init()
	
	private lazy var hashtagsVC: CxjParallaxScrollCollection.ViewController = {
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
	
	private lazy var dataSets: [[HashtagModel]] = getInitialData()
	private var selectedTags: Set<HashtagModel> = []

	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .white
		setupItemsCollection()
		setupCloseButton()
	}
	
	func setupItemsCollection() {
		view.addSubview(hashtagsVCPlaceholderView)
		hashtagsVCPlaceholderView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			hashtagsVCPlaceholderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			hashtagsVCPlaceholderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
			hashtagsVCPlaceholderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			hashtagsVCPlaceholderView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
		
		setupChildViaConstraints(hashtagsVC, to: hashtagsVCPlaceholderView)
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

extension HashtagsViewController: CxjParallaxScrollCollection.DataSource {
	var cellType: any CxjParallaxScrollCollection.ContentCell.Type { HashtagCell.self }

	func numberOfSections() -> Int { dataSets.count }

	func numberOfItemsInSection(_ sectionIndex: Int) -> Int {
		dataSets[sectionIndex].count
	}

	func cellModelForIndexPath(_ indexPath: IndexPath) -> any CxjParallaxScrollCollection.CellModel {
		let hashtag: HashtagModel = dataSets[indexPath.section][indexPath.row]
		let cellModel: HashtagCellModel = HashtagCellModel(
			name: hashtag.name,
			isSelected: selectedTags.contains(hashtag)
		)
		
		return cellModel
	}
}

extension HashtagsViewController: CxjParallaxScrollCollection.Delegate {
	func didSelectModelAtIndexPath(_ indexPath: IndexPath) {
		let hashtag: HashtagModel = dataSets[indexPath.section][indexPath.item]
		
		if selectedTags.contains(hashtag) {
			selectedTags.remove(hashtag)
		} else {
			selectedTags.insert(hashtag)
		}
		
		let action: (() -> Void) = {
			self.hashtagsVC.reconfigureItemAtIndexPath(indexPath)
		}
		
		UIView.animate(
			withDuration: 0.25,
			delay: .zero,
			options: [.beginFromCurrentState, .curveEaseOut, .allowUserInteraction],
			animations: action
		)
	}
}

private extension HashtagsViewController {
	func getInitialData() -> [[HashtagModel]] {
		[
			[
				HashtagModel(name: "UIKit"),
				HashtagModel(name: "SwiftUI"),
				HashtagModel(name: "CoreData"),
				HashtagModel(name: "CoreAnimation"),
				HashtagModel(name: "MapKit"),
				HashtagModel(name: "CoreLocation")
			],
			[
				HashtagModel(name: "ARKit"),
				HashtagModel(name: "RealityKit"),
				HashtagModel(name: "AVFoundation"),
				HashtagModel(name: "Vision"),
				HashtagModel(name: "HealthKit"),
				HashtagModel(name: "SpriteKit"),
				HashtagModel(name: "CloudKit")
			]
		]
	}
}
