//
//  CatInfoRowView.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 2/7/24.
//

import Foundation
import SwiftUI

struct CatInfoRowView: View {
	@EnvironmentObject var theme: CatThemeManager
	@ObservedObject var viewModel: CatInfoRowViewModel
	
	var body: some View {
		HStack {
			Text(viewModel.title)
				.font(theme.primaryFont)
				.foregroundColor(theme.primaryFontColorLight)
			Spacer()
			Text(viewModel.formattedValue)
				.font(theme.attrFont)
				.foregroundColor(theme.secondaryFontColorLight)
		}
	}
}

