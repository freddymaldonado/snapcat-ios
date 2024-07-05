//
//  CatErrorView.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 2/7/24.
//

import Foundation
import SwiftUI

struct CatErrorView: View {
	@EnvironmentObject var theme: CatThemeManager
	var error: NetworkError
	
	var body: some View {
		VStack(alignment: .center) {
			Text("Oops!")
				.font(theme.currentTheme.primaryFont)
				.foregroundColor(theme.currentTheme.primaryFontColorLight)
				.padding(.bottom, theme.currentTheme.basePadding)
			
			Text(error.errorDescription)
				.font(theme.currentTheme.secondaryFont)
				.foregroundColor(theme.currentTheme.secondaryFontColorLight)
				.multilineTextAlignment(.center)
				.padding()
				.background(Color.red.opacity(0.2))
				.cornerRadius(theme.currentTheme.cornerRadius)
				.padding()
		}
		.background(theme.currentTheme.backgroundColor)
		.cornerRadius(theme.currentTheme.cornerRadius)
		.padding()
		
	}
}
