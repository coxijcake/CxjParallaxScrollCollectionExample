//
//  ViewController.swift
//  CxjParallaxScrollCollectionExample
//
//  Created by Nikita Begletskiy on 16/03/2025.
//

import UIKit
import CxjParallaxScrollCollection


final class ViewController: UIViewController {
	// MARK: - Subviews
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
	
	private let plusButton = UIButton(type: .system)
	private let minusButton = UIButton(type: .system)
	private let reloadButton = UIButton(type: .system)
	
	//MARK: - Props
	private lazy var dataSets: [[TransportCellModel]] = getInitialData()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		addTransportsCollection()
		setupControlButtons()
	}
	
	//MARK: - Subviews configuration
	func addTransportsCollection() {
		setupChildViaConstraints(transportsVC, to: view)
	}
	
	private func setupControlButtons() {
		let stack = UIStackView(arrangedSubviews: [plusButton, minusButton, reloadButton])
		stack.axis = .horizontal
		stack.spacing = 12
		stack.distribution = .fillEqually
		view.addSubview(stack)
		
		plusButton.setTitle("+", for: .normal)
		minusButton.setTitle("-", for: .normal)
		reloadButton.setTitle("Reload", for: .normal)
		
		[plusButton, minusButton, reloadButton].forEach { $0.setTitleColor(.white, for: .normal) }
		
		plusButton.addTarget(self, action: #selector(didTapPlus), for: .touchUpInside)
		minusButton.addTarget(self, action: #selector(didTapMinus), for: .touchUpInside)
		reloadButton.addTarget(self, action: #selector(didTapReload), for: .touchUpInside)
		
		stack.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200),
			stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			stack.heightAnchor.constraint(equalToConstant: 44),
			stack.widthAnchor.constraint(equalToConstant: 200)
		])
	}
	
	// MARK: - Actions
	@objc private func didTapPlus() {
		let randomCount = Int.random(in: 5...15)
		let newSection = (0..<randomCount).map { _ in
			TransportCellModel(title: randomTransportTitle())
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
	
	private func randomTransportTitle() -> String {
		let options = [
			"Bus", "Car", "Train", "Ship", "Bike", "Airplane", "Other",
			"Moto", "Scooter", "Taxi", "Truck", "Van", "Metro", "Subway",
			"Tram", "Ferry", "Rickshaw", "Skateboard", "Rollerblades",
			"Segway", "Hoverboard", "Trolleybus", "CableCar", "Yacht",
			"Snowmobile", "ATV", "SUV", "Pickup", "Jet", "Helicopter"
		]
		return options.randomElement()!
	}
}

//MARK: - CxjParallaxScrollCollection.DataSource
extension ViewController: CxjParallaxScrollCollection.DataSource {
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
extension ViewController: CxjParallaxScrollCollection.Delegate {
	func didSelectModelAtIndexPath(_ indexPath: IndexPath) {
		dataSets[indexPath.section][indexPath.item].isSelected.toggle()
		transportsVC.reconfigureItemAtIndexPath(indexPath)
//		transportsVC.scrollToItemAt(indexPath: indexPath, atPosition: .center, animated: true)
	}
}

//MARK: - Initial Data
private extension ViewController {
	func getInitialData() -> [[TransportCellModel]] {
		[
			[
				TransportCellModel(title: "Bus"),
				TransportCellModel(title: "Car"),
				TransportCellModel(title: "Train"),
				TransportCellModel(title: "Ship"),
				TransportCellModel(title: "Bike"),
				TransportCellModel(title: "Airplane"),
				TransportCellModel(title: "Other"),
				TransportCellModel(title: "Moto"),
				TransportCellModel(title: "Scooter"),
				TransportCellModel(title: "Taxi"),
				TransportCellModel(title: "Truck"),
				TransportCellModel(title: "Van"),
				TransportCellModel(title: "Metro"),
				TransportCellModel(title: "Subway"),
				TransportCellModel(title: "Tram"),
				TransportCellModel(title: "Ferry")
			],
			[
				TransportCellModel(title: "Train"),
				TransportCellModel(title: "Ship"),
				TransportCellModel(title: "Bike"),
				TransportCellModel(title: "Airplane"),
				TransportCellModel(title: "Other"),
				TransportCellModel(title: "Moto"),
				TransportCellModel(title: "Scooter"),
				TransportCellModel(title: "Rickshaw"),
				TransportCellModel(title: "Skateboard"),
				TransportCellModel(title: "Rollerblades"),
				TransportCellModel(title: "Segway"),
				TransportCellModel(title: "Hoverboard"),
				TransportCellModel(title: "Trolleybus"),
				TransportCellModel(title: "CableCar")
			],
			[
				TransportCellModel(title: "Car"),
				TransportCellModel(title: "Bike"),
				TransportCellModel(title: "Airplane"),
				TransportCellModel(title: "Moto"),
				TransportCellModel(title: "Scooter"),
				TransportCellModel(title: "Boat"),
				TransportCellModel(title: "Ferry"),
				TransportCellModel(title: "Helicopter"),
				TransportCellModel(title: "Balloon"),
				TransportCellModel(title: "Jet"),
				TransportCellModel(title: "Cruise"),
				TransportCellModel(title: "Sailboat"),
				TransportCellModel(title: "Yacht"),
				TransportCellModel(title: "Submarine")
			],
			[
				TransportCellModel(title: "Bus"),
				TransportCellModel(title: "Car"),
				TransportCellModel(title: "Bike"),
				TransportCellModel(title: "Airplane"),
				TransportCellModel(title: "Tram"),
				TransportCellModel(title: "Monorail"),
				TransportCellModel(title: "Golf Cart"),
				TransportCellModel(title: "Snowmobile"),
				TransportCellModel(title: "ATV"),
				TransportCellModel(title: "SUV"),
				TransportCellModel(title: "Pickup")
			]
		]
	}
}
