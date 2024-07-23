//
//  CatAnimatedButtonStyle.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 2/7/24.
//

import Foundation
import SwiftUI

struct CatAnimatedButtonStyle: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.scaleEffect(configuration.isPressed ? 0.95 : 1.0)
			.opacity(configuration.isPressed ? 0.7 : 1.0)
			.animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
			.contentShape(Rectangle())
	}
}
