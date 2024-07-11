//
//  CatErrorViewModel.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 8/7/24.
//

import Foundation
import SwiftUI

class CatErrorViewModel: CatErrorViewModelProtocol {
	@Published var error: NetworkError
	
	init(error: NetworkError) {
		self.error = error
	}
	
	var errorDescription: String {
		return error.errorDescription
	}
}
