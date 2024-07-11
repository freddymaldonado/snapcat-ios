//
//  CatSettingsView.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 2/7/24.
//

import Foundation
import SwiftUI

struct CatSettingsView: View {
	@EnvironmentObject var themeManager: CatThemeManager
	@ObservedObject var viewModel: CatSettingsViewModel
	
	var body: some View {
		List {
			Section(header: Text("Appearance")) {
				Toggle(isOn: $viewModel.isDarkMode) {
					Text(viewModel.isDarkMode ? "Dark Mode" : "Light Mode")
						.foregroundColor(themeManager.tintColor)
				}
				.setAccessibilityIdentifier("ThemeToggle")
				.toggleStyle(SwitchToggleStyle(tint: themeManager.tintColor))
				.onChange(of: viewModel.isDarkMode) {
					themeManager.switchTheme(to: viewModel.isDarkMode ? .darkTheme : .lightTheme)
				}
			}
			.combineAccessibilityElements()
			.accessibleLabel("This is a switch where you can toogle dark or light mode")
		}
		.navigationTitle("Settings")
		.navigationBarTitleDisplayMode(.inline)
		.listStyle(InsetGroupedListStyle())
	}
}
