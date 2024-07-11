//
//  CatDetailTagView.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 2/7/24.
//

import Foundation
import SwiftUI

struct CatDetailTagView: View {
	@EnvironmentObject var theme: CatThemeManager
	@ObservedObject var viewModel: CatDetailTagViewModel
	
	var body: some View {
		Section(header: Text("Tags")) {
			if let tags = viewModel.tags {
				if tags.isEmpty {
					Text(viewModel.noTagsText)
				} else {
					CatTagView(
						viewModel: CatTagViewModel(
							data: tags,
							spacing: theme.tagSpacing,
							alignment: .leading,
							content: { item in
								Text(verbatim: item)
									.font(theme.tagFont)
									.foregroundColor(theme.tagFontColor)
									.padding(theme.basePadding)
									.background(
										RoundedRectangle(cornerRadius: theme.cornerRadius / 2.0)
											.fill(theme.tagBackgroundColor.opacity(theme.tagOpacity))
									)
							}
						)
					)
				}
			}
		}
		.listRowBackground(Color.clear)
		.listRowSeparator(.hidden)
	}
}
