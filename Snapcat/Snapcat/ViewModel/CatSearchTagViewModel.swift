//
//  CatSearchTagViewModel.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 22/7/24.
//

import Combine
import SwiftUI

class CatSearchTagViewModel: ObservableObject {
	@Published var tags: [String]
	var searchAction: (String) -> Void
	var isTagSelectedAction: (String) -> Bool
	
	init(tags: [String], searchAction: @escaping (String) -> Void, isTagSelectedAction: @escaping (String) -> Bool) {
		self.tags = tags
		self.searchAction = searchAction
		self.isTagSelectedAction = isTagSelectedAction
	}
	
	func search(tag: String) {
		searchAction(tag)
	}
	
	func isTagSelected(_ tag: String) -> Bool {
		return isTagSelectedAction(tag)
	}
}
