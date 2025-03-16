//
//  BounceOnTouchCollectionViewCell.swift
//  CxjParallaxScrollCollectionExample
//
//  Created by Nikita Begletskiy on 16/03/2025.
//

import UIKit

class BounceOnTouchCollectionViewCell: UICollectionViewCell {
	//MARK: - Animating props values
	var alphaOnTouch: CGFloat { 0.975 }
	var defaultAlpha: CGFloat { 1.0 }
	
	var scaleOnTouch: CGFloat { 0.985 }
	var defaultTransform: CGAffineTransform { .identity }
	
	override var isHighlighted: Bool {
		didSet {
			updateUI(isTouching: isHighlighted, animated: true)
		}
	}
	
	final func updateUI(isTouching: Bool, animated: Bool) {
		let alpha: CGFloat = isTouching ? alphaOnTouch : defaultAlpha
		let transform: CGAffineTransform = isTouching
		? .init(scaleX: scaleOnTouch, y: scaleOnTouch)
		: defaultTransform
		
		let animations: (() -> Void) = {
			self.alpha = alpha
			self.transform = transform
		}
		
		if animated {
			UIView.animate(
				withDuration: 0.15,
				delay: .zero,
				options: [.allowUserInteraction, .beginFromCurrentState, .curveLinear],
				animations: animations
			)
		} else {
			animations()
		}
	}
}
