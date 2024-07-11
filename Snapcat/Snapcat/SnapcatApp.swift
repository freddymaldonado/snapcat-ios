//
//  SnapcatApp.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 1/7/24.
//

import SwiftUI
import FirebaseCore
import FirebaseAnalyticsSwift

class AppDelegate: NSObject, UIApplicationDelegate {
	func application(_ application: UIApplication,
					 didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
		FirebaseApp.configure()
		return true
	}
}

@main
struct SnapcatApp: App {
	@UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
	let themeManager = CatThemeManager.shared
	
    var body: some Scene {
        WindowGroup {
            ContentView()
				.environmentObject(themeManager)
				.applyColorScheme(themeManager)
        }
    }
}
