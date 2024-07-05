//
//  CatSettingsView.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 2/7/24.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

import SwiftUI

struct CatSettingsView: View {
	@EnvironmentObject var themeManager: CatThemeManager
	@State private var isAlertPresented = false
	
	func clearCache() {
		SDImageCachesManager.shared.clear(with: .all)
		isAlertPresented = true
	}
	
	var body: some View {
		List {
			Section(header: Text("Appearance")) {
				Toggle(isOn: Binding(
					get: { themeManager.currentTheme == .darkTheme },
					set: { newValue in
						themeManager.switchTheme(to: newValue ? .darkTheme : .lightTheme)
					}
				)) {
					Text("Dark Mode")
						.foregroundColor(themeManager.tintColor)
				}
				.toggleStyle(SwitchToggleStyle(tint: themeManager.tintColor))
			}
			
			Section(header: Text("Cache")) {
				Button(action: clearCache) {
					Text("Clear Cache")
						.foregroundColor(themeManager.tintColor)
				}
			}
		}
		.alert(isPresented: $isAlertPresented) {
			Alert(
				title: Text("Cache Cleared"),
				message: Text("The cache has been successfully cleared."),
				dismissButton: .default(Text("OK"))
			)
		}
		.navigationTitle("Settings")
		.navigationBarTitleDisplayMode(.inline)
		.listStyle(InsetGroupedListStyle())
	}
}
