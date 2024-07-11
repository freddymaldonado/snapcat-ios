//
//  CatInfoViewModel.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 8/7/24.
//

import Foundation
import SwiftUI

class CatInfoViewModel: CatInfoViewModelProtocol {
	@Published var details: [CatInfoRow]
	
	init(details: [CatInfoRow]) {
		self.details = details
	}
}
