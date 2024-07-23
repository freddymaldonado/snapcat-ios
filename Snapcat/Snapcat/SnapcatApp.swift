//
//  SnapcatApp.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 1/7/24.
//

import SwiftUI

@main
struct SnapcatApp: App {
	let themeManager = CatThemeManager.shared
	
    var body: some Scene {
        WindowGroup {
            ContentView()
				.environmentObject(themeManager)
				.applyColorScheme(themeManager)
        }
    }
}
