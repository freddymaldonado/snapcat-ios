//
//  CatSettingsViewModelProtocol.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 9/7/24.
//

import Foundation

protocol CatSettingsViewModelProtocol: ObservableObject {
	var isDarkMode: Bool { get set }
}
