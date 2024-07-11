//
//  CatFont.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 9/7/24.
//

import SwiftUI

enum CatFont: String {
	case meows = "Meows-Regular"
	case ralewayLight = "Raleway-Light"
	case ralewayMedium = "Raleway-Medium"
	case ralewaySemiBold = "Raleway-SemiBold"

	func font(size: CGFloat, weight: Font.Weight = .regular) -> Font {
		return FontManager.shared.customFont(name: self.rawValue, size: size, weight: weight)
	}
	
	func font(size: CGFloat, weight: Font.Weight = .regular) -> UIFont {
		return FontManager.shared.customFont(name: self.rawValue, size: size, weight: weight)
	}
}
