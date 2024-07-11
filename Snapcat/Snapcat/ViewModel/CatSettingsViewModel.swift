//
//  CatSettingsViewModel.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 8/7/24.
//

import Foundation
import SwiftUI

class CatSettingsViewModel: CatSettingsViewModelProtocol {
	@Published var isDarkMode: Bool
	
	init(isDarkMode: Bool) {
		self.isDarkMode = isDarkMode
	}
}
