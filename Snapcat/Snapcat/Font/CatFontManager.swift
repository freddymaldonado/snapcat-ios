//
//  CatFontManager.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 9/7/24.
//

import SwiftUI

class FontManager {
	static let shared = FontManager()
	
	private init() { }
	
	func customFont(name: String, size: CGFloat, weight: Font.Weight) -> Font {
		guard let uiFont = UIFont(name: name, size: size) else {
			fatalError("Failed to load the font named \(name). Ensure the font file is included in the project and the font name is spelled correctly in the Info.plist.")
		}
		let scaledFont = UIFontMetrics.default.scaledFont(for: uiFont.withWeight(weight))
		return Font(scaledFont)
	}
	
	func customFont(name: String, size: CGFloat, weight: Font.Weight) -> UIFont {
		guard let uiFont = UIFont(name: name, size: size) else {
			fatalError("Failed to load the font named \(name). Ensure the font file is included in the project and the font name is spelled correctly in the Info.plist.")
		}
		let scaledFont = UIFontMetrics.default.scaledFont(for: uiFont.withWeight(weight))
		return scaledFont
	}
}

private extension UIFont {
	func withWeight(_ weight: Font.Weight) -> UIFont {
		let traits: [UIFontDescriptor.TraitKey: Any]
		switch weight {
			case .ultraLight: traits = [.weight: UIFont.Weight.ultraLight]
			case .thin: traits = [.weight: UIFont.Weight.thin]
			case .light: traits = [.weight: UIFont.Weight.light]
			case .regular: traits = [.weight: UIFont.Weight.regular]
			case .medium: traits = [.weight: UIFont.Weight.medium]
			case .semibold: traits = [.weight: UIFont.Weight.semibold]
			case .bold: traits = [.weight: UIFont.Weight.bold]
			case .heavy: traits = [.weight: UIFont.Weight.heavy]
			case .black: traits = [.weight: UIFont.Weight.black]
			default: traits = [.weight: UIFont.Weight.regular]
		}
		let descriptor = self.fontDescriptor.addingAttributes([.traits: traits])
		return UIFont(descriptor: descriptor, size: 0)
	}
}

