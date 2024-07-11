//
//  CatElementView.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 2/7/24.
//

import Foundation
import SwiftUI

struct CatContentView: View {
	@EnvironmentObject var theme: CatThemeManager
	@ObservedObject var viewModel: CatContentViewModel
	
	var body: some View {
		switch viewModel.content {
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
					.font(theme.tagFont)
					.padding(theme.basePadding)
					.background(CatBlurView(style: theme.lightBackgroundBlurStyle))
					.clipShape(RoundedRectangle(cornerRadius: theme.cornerRadius))
					.foregroundColor(theme.secondaryFontColor)
					.padding(theme.basePadding)
		}
	}
}
