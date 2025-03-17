//
//  HashtagModel.swift
//  CxjParallaxScrollCollectionExample
//
//  Created by Nikita Begletskiy on 17/03/2025.
//

import Foundation

struct HashtagModel: Hashable {
	let id: UUID
	let name: String
	
	init(id: UUID = UUID(), name: String) {
		self.id = id
		self.name = name
	}
}
