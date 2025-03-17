//
//  TransportsViewController.swift
//  CxjParallaxScrollCollectionExample
//
//  Created by Nikita Begletskiy on 17/03/2025.
//

import UIKit
import CxjParallaxScrollCollection

final class TransportsViewController: UIViewController {
	// MARK: - Subviews
	private let transportsVCPlaceholderView: UIView = .init()
	private let controlsStackView: UIStackView = .init()
	private let plusButton = UIButton(type: .system)
	private let minusButton = UIButton(type: .system)
	private let reloadButton = UIButton(type: .system)
	private let closeButton = UIButton(type: .system)
	
	//MARK: - Childs
	private lazy var transportsVC: CxjParallaxScrollCollection.ViewController = {
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
	
	//MARK: - Props
	private lazy var dataSets: [[TransportCellModel]] = getInitialData()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .white
		setupControlButtons()
		addTransportsCollection()
	}
	
	//MARK: - Subviews configuration
	func addTransportsCollection() {
		view.addSubview(transportsVCPlaceholderView)
		transportsVCPlaceholderView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			transportsVCPlaceholderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			transportsVCPlaceholderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
			transportsVCPlaceholderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			transportsVCPlaceholderView.bottomAnchor.constraint(equalTo: controlsStackView.topAnchor)
		])
		
		setupChildViaConstraints(transportsVC, to: transportsVCPlaceholderView)
	}
	
	private func setupControlButtons() {
		[plusButton, minusButton, reloadButton].forEach { controlsStackView.addArrangedSubview($0) }
		controlsStackView.axis = .horizontal
		controlsStackView.spacing = 12
		controlsStackView.distribution = .fillEqually
		view.addSubview(controlsStackView)
		
		plusButton.setTitle("+", for: .normal)
		minusButton.setTitle("-", for: .normal)
		reloadButton.setTitle("Reload", for: .normal)
		
		[plusButton, minusButton, reloadButton].forEach { $0.setTitleColor(.black, for: .normal) }
		
		plusButton.addTarget(self, action: #selector(didTapPlus), for: .touchUpInside)
		minusButton.addTarget(self, action: #selector(didTapMinus), for: .touchUpInside)
		reloadButton.addTarget(self, action: #selector(didTapReload), for: .touchUpInside)
		
		controlsStackView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			controlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
			controlsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			controlsStackView.heightAnchor.constraint(equalToConstant: 44),
			controlsStackView.widthAnchor.constraint(equalToConstant: 200)
		])
		
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
	
	@objc private func didTapPlus() {
		let randomCount = Int.random(in: 5...15)
		let newSection = (0..<randomCount).map { _ in
			randomTransport()
		}
		
		dataSets.append(newSection)
	}
	
	@objc private func didTapMinus() {
		guard !dataSets.isEmpty else { return }
		dataSets.removeLast()
	}
	
	@objc private func didTapReload() {
		transportsVC.reloadData()
	}
	
	
	
	private func randomTransport() -> TransportCellModel {
		let options: [TransportCellModel] = [
			TransportCellModel(title: "Bus", icon: "🚌"),
			TransportCellModel(title: "Car", icon: "🚗"),
			TransportCellModel(title: "Train", icon: "🚆"),
			TransportCellModel(title: "Ship", icon: "🚢"),
			TransportCellModel(title: "Bike", icon: "🚲"),
			TransportCellModel(title: "Airplane", icon: "✈️"),
			TransportCellModel(title: "Other", icon: "🚘"),
			TransportCellModel(title: "Bike", icon: "🚲"),
			TransportCellModel(title: "Airplane", icon: "✈️"),
			TransportCellModel(title: "Tram", icon: "🚋"),
			TransportCellModel(title: "Monorail", icon: "🚝"),
			TransportCellModel(title: "Golf Cart", icon: "🏎"),
			TransportCellModel(title: "Snowmobile", icon: "🛷")
		]
		
		return options.randomElement()!
	}
}

//MARK: - CxjParallaxScrollCollection.DataSource
extension TransportsViewController: CxjParallaxScrollCollection.DataSource {
	var cellType: any CxjParallaxScrollCollection.ContentCell.Type {
		TransportCell.self
	}
	
	func numberOfSections() -> Int {
		dataSets.count
	}
	
	func numberOfItemsInSection(_ sectionIndex: Int) -> Int {
		dataSets[sectionIndex].count
	}
	
	func cellModelForIndexPath(_ indexPath: IndexPath) -> any CxjParallaxScrollCollection.CellModel {
		dataSets[indexPath.section][indexPath.row]
	}
}

//MARK: - CxjParallaxScrollCollection.Delegate
extension TransportsViewController: CxjParallaxScrollCollection.Delegate {
	func didSelectModelAtIndexPath(_ indexPath: IndexPath) {
		dataSets[indexPath.section][indexPath.item].isSelected.toggle()
		transportsVC.reconfigureItemAtIndexPath(indexPath)
//		transportsVC.scrollToItemAt(indexPath: indexPath, atPosition: .center, animated: true)
	}
}

//MARK: - Initial Data
private extension TransportsViewController {
	func getInitialData() -> [[TransportCellModel]] {
		[
			[
				TransportCellModel(title: "Bus", icon: "🚌"),
				TransportCellModel(title: "Car", icon: "🚗"),
				TransportCellModel(title: "Train", icon: "🚆"),
				TransportCellModel(title: "Ship", icon: "🚢"),
				TransportCellModel(title: "Bike", icon: "🚲"),
				TransportCellModel(title: "Airplane", icon: "✈️"),
				TransportCellModel(title: "Other", icon: "🚘"),
				TransportCellModel(title: "Moto", icon: "🏍"),
				TransportCellModel(title: "Scooter", icon: "🛵"),
				TransportCellModel(title: "Taxi", icon: "🚕"),
				TransportCellModel(title: "Truck", icon: "🚚"),
				TransportCellModel(title: "Van", icon: "🚐"),
				TransportCellModel(title: "Metro", icon: "🚇"),
				TransportCellModel(title: "Subway", icon: "🚊"),
				TransportCellModel(title: "Tram", icon: "🚋"),
				TransportCellModel(title: "Ferry", icon: "⛴")
			],
			[
				TransportCellModel(title: "Train", icon: "🚆"),
				TransportCellModel(title: "Ship", icon: "🚢"),
				TransportCellModel(title: "Bike", icon: "🚲"),
				TransportCellModel(title: "Airplane", icon: "✈️"),
				TransportCellModel(title: "Other", icon: "🚘"),
				TransportCellModel(title: "Moto", icon: "🏍"),
				TransportCellModel(title: "Scooter", icon: "🛵"),
				TransportCellModel(title: "Rickshaw", icon: "🛺"),
				TransportCellModel(title: "Skateboard", icon: "🛹"),
				TransportCellModel(title: "Rollerblades", icon: "🛼"),
				TransportCellModel(title: "Segway", icon: "🛴"),
				TransportCellModel(title: "Hoverboard", icon: "🛸"),
				TransportCellModel(title: "Trolleybus", icon: "🚎"),
				TransportCellModel(title: "CableCar", icon: "🚡")
			],
			[
				TransportCellModel(title: "Car", icon: "🚗"),
				TransportCellModel(title: "Bike", icon: "🚲"),
				TransportCellModel(title: "Airplane", icon: "✈️"),
				TransportCellModel(title: "Moto", icon: "🏍"),
				TransportCellModel(title: "Scooter", icon: "🛵"),
				TransportCellModel(title: "Boat", icon: "🚤"),
				TransportCellModel(title: "Ferry", icon: "⛴"),
				TransportCellModel(title: "Helicopter", icon: "🚁"),
				TransportCellModel(title: "Balloon", icon: "🎈"),
				TransportCellModel(title: "Jet", icon: "🛩"),
				TransportCellModel(title: "Cruise", icon: "🛳"),
				TransportCellModel(title: "Sailboat", icon: "⛵️"),
				TransportCellModel(title: "Yacht", icon: "🛥"),
				TransportCellModel(title: "Submarine", icon: "🛳")
			],
			[
				TransportCellModel(title: "Bus", icon: "🚌"),
				TransportCellModel(title: "Car", icon: "🚗"),
				TransportCellModel(title: "Bike", icon: "🚲"),
				TransportCellModel(title: "Airplane", icon: "✈️"),
				TransportCellModel(title: "Tram", icon: "🚋"),
				TransportCellModel(title: "Monorail", icon: "🚝"),
				TransportCellModel(title: "Golf Cart", icon: "🏎"),
				TransportCellModel(title: "Snowmobile", icon: "🛷"),
				TransportCellModel(title: "ATV", icon: "🚙"),
				TransportCellModel(title: "SUV", icon: "🚙"),
				TransportCellModel(title: "Pickup", icon: "🛻")
			]
		]
	}
}
