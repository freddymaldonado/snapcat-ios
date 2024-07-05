//
//  CatThemeManager.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 2/7/24.
//

import Combine
import SwiftUI

struct ColorSchemeUpdater: ViewModifier {
	@ObservedObject var themeManager: CatThemeManager
	
	func body(content: Content) -> some View {
		content
			.preferredColorScheme(themeManager.colorScheme)
	}
}

extension View {
	func applyColorScheme(_ themeManager: CatThemeManager) -> some View {
		self.modifier(ColorSchemeUpdater(themeManager: themeManager))
	}
}

class CatThemeManager: ObservableObject {
	@Published var currentTheme: CatTheme = .lightTheme
	@Published var colorScheme: ColorScheme = .light

	static let shared = CatThemeManager()
	
	private init() {
		colorScheme = (currentTheme == .darkTheme) ? .dark : .light
	}
	
	func switchTheme(to theme: CatTheme) {
		currentTheme = theme
		colorScheme = (currentTheme == .darkTheme) ? .dark : .light
	}
	
	var tintColor: Color {
		currentTheme.tintColor
	}
	
	var backgroundColor: Color {
		currentTheme.backgroundColor
	}
	
	var primaryFont: Font {
		currentTheme.primaryFont
	}
	
	var secondaryFont: Font {
		currentTheme.secondaryFont
	}
	
	var primaryFontColor: Color {
		currentTheme.primaryFontColor
	}
	
	var secondaryFontColor: Color {
		currentTheme.secondaryFontColor
	}
	
	var primaryFontColorLight: Color {
		currentTheme.primaryFontColorLight
	}
	
	var secondaryFontColorLight: Color {
		currentTheme.secondaryFontColorLight
	}
	
	var cornerRadius: CGFloat {
		currentTheme.cornerRadius
	}
	
	var basePadding: CGFloat {
		currentTheme.basePadding
	}
	
	var baseSpacing: CGFloat {
		currentTheme.baseSpacing
	}
	
	var tagSpacing: CGFloat {
		currentTheme.tagSpacing
	}
	
	var tagOpacity: CGFloat {
		currentTheme.tagOpacity
	}

	var tagBackgroundColor: Color {
		currentTheme.tagBackgroundColor
	}
	
	var tagFont: Font {
		currentTheme.tagFont
	}
	
	var tagFontColor: Color {
		currentTheme.tagFontColor
	}
	
	var iconSize: CGFloat {
		currentTheme.iconSize
	}
	
	var mediaPlaceholderColor: Color {
		currentTheme.mediaPlaceholderColor
	}
	
	var darkBackgroundBlurStyle: UIBlurEffect.Style {
		currentTheme.darkBackgroundBlurStyle
	}
	
	var lightBackgroundBlurStyle: UIBlurEffect.Style {
		currentTheme.lightBackgroundBlurStyle
	}
}
