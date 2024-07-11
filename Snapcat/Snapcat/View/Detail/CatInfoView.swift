//
//  CatInfoView.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 2/7/24.
//

import Foundation
import SwiftUI

struct CatInfoView: View {
	@EnvironmentObject var theme: CatThemeManager
	@ObservedObject var viewModel: CatInfoViewModel
	
	var body: some View {
		Section(header: Text("Info")) {
			ForEach(viewModel.details, id: \.title) { detail in
				CatInfoRowView(
					viewModel: CatInfoRowViewModel(
						title: detail.title,
						value: detail.value
					)
				)
			}
		}
		.listRowBackground(Color.clear)
		.listRowSeparatorTint(Color.gray)
	}
}
