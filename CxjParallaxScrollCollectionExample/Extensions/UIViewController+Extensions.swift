//
//  UIViewController+Extensions.swift
//  CxjParallaxScrollCollectionExample
//
//  Created by Nikita Begletskiy on 16/03/2025.
//

import UIKit

extension UIViewController {
	func setupChildViaConstraints(_ childVc: UIViewController?, to container: UIView) {
		if let childVC = childVc {
			childVC.willMove(toParent: self)
			
			addChild(childVC)
			
			if let childView = childVC.view {
				container.addSubview(childView)
				childView.translatesAutoresizingMaskIntoConstraints = false
				childView.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
				childView.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
				childView.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
				childView.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
			}
			
			childVC.didMove(toParent: self)
		}
	}
	
	func setupChildViaAutoresizingMask(_ childVc: UIViewController?, toContainer container: UIView) {
		guard let childVc else { return }
		
		childVc.willMove(toParent: self)
		addChild(childVc)
		
		container.addSubview(childVc.view)
		childVc.view.frame = container.bounds
		childVc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		
		childVc.didMove(toParent: self)
	}
	
	func removeAsChild() {
		guard parent != nil else { return }
		
		willMove(toParent: nil)
		view.removeFromSuperview()
		removeFromParent()
	}
}
