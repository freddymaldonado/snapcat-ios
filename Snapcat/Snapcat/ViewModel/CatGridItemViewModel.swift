//
//  CatGridItemViewModel.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 8/7/24.
//

import Foundation
import Combine
import SwiftUI

class CatGridItemViewModel: CatGridItemViewModelProtocol {
	@Published var error: NetworkError? = nil
	@Published var size: CGFloat
	var cat: Cat?

	
	init(size: CGFloat, cat: Cat?) {
		self.size = size
		self.cat = cat
	}
	
	var contentUrl: URL? {
		return cat?.contentURL
	}
	
	var previewTags: String? {
		return cat?.previewTags
	}
	
	var typeIcon: String {
		guard let cat = cat else { return "camera.metering.unknown" }
		return cat.isGif ? "rectangle.stack.badge.play" : "photo"
	}
}
