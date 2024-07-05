//
//  CatColorExtensions.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 2/7/24.
//

import Foundation
import SwiftUI

extension Color {
	func lighten(by amount: CGFloat) -> Color {
		var red: CGFloat = 0
		var green: CGFloat = 0
		var blue: CGFloat = 0
		var opacity: CGFloat = 0
		
		UIColor(self).getRed(&red, green: &green, blue: &blue, alpha: &opacity)
		
		red = min(red + (1.0 - red) * amount, 1.0)
		green = min(green + (1.0 - green) * amount, 1.0)
		blue = min(blue + (1.0 - blue) * amount, 1.0)
		
		return Color(red: Double(red), green: Double(green), blue: Double(blue), opacity: Double(opacity))
	}
}
