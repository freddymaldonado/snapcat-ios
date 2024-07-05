//
//  CatDetailView.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 1/7/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct CatDetailView: View {
	@EnvironmentObject var theme: CatThemeManager
	@ObservedObject private var viewModel: CatDetailViewModel
	@State private var isFullScreenImagePresented = false
	
	init(catId: String) {
		viewModel = CatDetailViewModel(catId: catId)
	}
	
	var body: some View {
		VStack {
			if let error = viewModel.error {
				CatErrorView(
					error: error
				)
			} else if viewModel.isLoading {
				ProgressView()
					.tint(theme.tintColor)
			} else {
				List {
					CatDetailContentView(
						isFullScreenImagePresented: $isFullScreenImagePresented,
						contentUrl: viewModel.contentUrl
					)
					.accessibility(identifier: "CatDetailContentView")
					
					CatDetailTagView(
						tags: viewModel.tags
					)
					.accessibility(identifier: "CatDetailTagView")
					
					CatInfoView(
						details: viewModel.catDetails
					)
					.accessibility(identifier: "CatInfoView")
				}
				.background(theme.backgroundColor)
				.scrollContentBackground(.hidden)
				.listSectionSpacing(theme.basePadding)
				.navigationTitle("Cat Details")
			}
		}
	}
}
