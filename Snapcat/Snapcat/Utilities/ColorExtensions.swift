//
//  ColorExtensions.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 9/7/24.
//

import SwiftUI

extension Color {
	func toUIColor() -> UIColor {
		let components = self.cgColor?.components
		let red = components?[0] ?? 0.0
		let green = components?[1] ?? 0.0
		let blue = components?[2] ?? 0.0
		let alpha = components?[3] ?? 1.0
		
		return UIColor(red: red, green: green, blue: blue, alpha: alpha)
	}
}
