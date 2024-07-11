//
//  CatContentViewModel.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 8/7/24.
//

import Foundation
import SwiftUI

enum CatContent {
	case text(String)
	case icon(Image)
}

class CatContentViewModel: CatContentViewModelProtocol {
	@Published var content: CatContent
	
	init(content: CatContent) {
		self.content = content
	}
}
