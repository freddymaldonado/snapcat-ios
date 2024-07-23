//
//  CatSearchTagView.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 22/7/24.
//

import SwiftUI

struct CatSearchTagView: View {
	@EnvironmentObject var theme: CatThemeManager
	@ObservedObject var viewModel: CatSearchTagViewModel
	
	var body: some View {
		ScrollView(.horizontal) {
			HStack {
				ForEach(viewModel.tags, id: \.self) { tag in
					Button(action: {
						viewModel.search(tag: tag)
					}) {
						Text(tag)
							.padding(theme.basePadding)
							.foregroundColor(theme.tagFontColor)
							.background(viewModel.isTagSelected(tag) ? theme.selectedTagBackgroundColor.opacity(theme.selectedTagOpacity) : theme.tagBackgroundColor.opacity(theme.tagOpacity))
							.cornerRadius(theme.cornerRadius)
					}
					.buttonStyle(CatAnimatedButtonStyle())
				}
			}
		}
		.scrollIndicators(.hidden)
		.padding(theme.basePadding * 2)
	}
}
