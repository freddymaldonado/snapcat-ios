//
//  CatElementView.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 2/7/24.
//

import Foundation
import SwiftUI

enum CatContent {
	case text(String)
	case icon(Image)
}

struct CatContentView: View {
	@EnvironmentObject var theme: CatThemeManager
	let content: CatContent
	
	var body: some View {
		switch content {
			case .icon(let icon):
				icon
					.resizable()
					.scaledToFit()
					.frame(width: theme.iconSize, height: theme.iconSize)
					.foregroundColor(theme.tintColor)
					.padding(theme.basePadding)
					.background(CatBlurView(style: theme.darkBackgroundBlurStyle))
					.clipShape(Circle())
			case .text(let text):
				Text(text)
					.font(theme.secondaryFont)
					.padding(theme.basePadding)
					.background(CatBlurView(style: theme.lightBackgroundBlurStyle))
					.clipShape(RoundedRectangle(cornerRadius: theme.cornerRadius))
					.foregroundColor(theme.secondaryFontColor)
					.padding(theme.basePadding)
		}
	}
}
