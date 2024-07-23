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
	@ObservedObject var viewModel: CatErrorViewModel
	
	var body: some View {
		VStack(spacing: .zero) {
			Spacer()
			VStack(alignment: .center, spacing: .zero) {
				Image(systemName: "wifi.exclamationmark")
					.resizable()
					.renderingMode(.template)
					.foregroundColor(.red)
					.scaledToFit()
					.frame(maxWidth: .infinity, maxHeight: 60)
					.padding()
				
				Text(viewModel.errorDescription)
					.font(theme.currentTheme.secondaryFont)
					.foregroundColor(.red)
					.multilineTextAlignment(.center)
					.padding()
					.background(.red.opacity(0.2))
					.cornerRadius(theme.currentTheme.cornerRadius)
					.padding()
			}
			.background(.red.opacity(0.1))
			.cornerRadius(theme.currentTheme.cornerRadius)
			.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
			Spacer()
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
	}
}
