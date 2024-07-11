//
//  CatDetailTagViewModel.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 8/7/24.
//

import Foundation
import SwiftUI

class CatDetailTagViewModel: CatDetailTagViewModelProtocol {
	@Published var tags: [String]?
	
	init(tags: [String]?) {
		self.tags = tags
	}
	
	var hasTags: Bool {
		return tags?.isEmpty == false
	}
	
	var noTagsText: String {
		return "No Tags"
	}
}
