//
//  ViewController.swift
//  CxjParallaxScrollCollectionExample
//
//  Created by Nikita Begletskiy on 16/03/2025.
//

import UIKit

final class ViewController: UIViewController {
	// MARK: - Subviews
	private let stackView = UIStackView()
	private let hashtagsButton = UIButton(type: .system)
	private let transportButton = UIButton(type: .system)
	private let foodButton = UIButton(type: .system)
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		setupStackView()
		setupButtons()
	}
	
	private func setupStackView() {
		view.addSubview(stackView)
		stackView.axis = .vertical
		stackView.spacing = 16
		stackView.alignment = .center
		stackView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		])
		
		[hashtagsButton, transportButton, foodButton].forEach { stackView.addArrangedSubview($0) }
	}
	
	private func setupButtons() {
		hashtagsButton.setTitle("Tags", for: .normal)
		transportButton.setTitle("Transport", for: .normal)
		foodButton.setTitle("Foodies", for: .normal)
		
		[hashtagsButton, transportButton, foodButton].forEach {
			$0.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
			$0.setTitleColor(.white, for: .normal)
			$0.backgroundColor = .systemBlue
			$0.layer.cornerRadius = 10
			$0.contentEdgeInsets = UIEdgeInsets(top: 10, left: 24, bottom: 10, right: 24)
		}
		
		hashtagsButton.addTarget(self, action: #selector(openHashtags), for: .touchUpInside)
		transportButton.addTarget(self, action: #selector(openTransport), for: .touchUpInside)
		foodButton.addTarget(self, action: #selector(openDrinks), for: .touchUpInside)
	}
	
	// MARK: - Actions
	@objc private func openHashtags() {
		routeToVc(HashtagsViewController())
	}
	
	@objc private func openTransport() {
		routeToVc(TransportsViewController())
	}
	
	@objc private func openDrinks() {
		routeToVc(FoodiesViewController())
	}
	
	func routeToVc(_ vc: UIViewController, animated: Bool = true) {
		vc.modalPresentationStyle = .fullScreen
		present(vc, animated: true)
	}
}
