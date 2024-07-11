//
//  CatDetailView.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 1/7/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct CatDetailView: View {
	@ObservedObject var viewModel: CatDetailViewModel
	@EnvironmentObject private var theme: CatThemeManager
	
	var body: some View {
		VStack {
			if viewModel.isLoading {
				ProgressView()
					.tint(theme.tintColor)
			} else {
				List {
					if let error = viewModel.contentError {
						Section(header: Text("Content")) {
							CatErrorView(
								viewModel: CatErrorViewModel(
									error: error.adding("The image could not be retrieved. This might be due to a network issue or the image being unavailable on the server. Please check your connection and try again.")
								)
							).accessibleLabel("The cat image is not available, this might be due to a network issue or the image being unavailable on the server.")
						}
					} else {
						CatDetailContentView(viewModel: CatDetailContentViewModel(
							contentUrl: viewModel.contentUrl,
							error: $viewModel.contentError)
						)
						.combineAccessibilityElements()
						.setAccessibilityIdentifier("CatDetailContentView")
						.removeAccessibilityImageTrait()
						.addAccessibilityButtonTrait()
						.accessibleLabel("This is the cat content image or animated image, dobule tap to preview the content in a full sccreen view, where you can also share it")
					}
					
					if let tags = viewModel.tags {
						CatDetailTagView(
							viewModel: CatDetailTagViewModel(
								tags: tags
							)
						)
						.setAccessibilityIdentifier("CatDetailTagView")
						.combineAccessibilityElements()
						.accessibleLabel("These are the cat tags: \(viewModel.accessibleTags)")
					}
					
					if let error = viewModel.detailError {
						Section(header: Text("Info")) {
							CatErrorView(
								viewModel: CatErrorViewModel(
									error: error.adding("The details of the image could not be retrieved. This may be due to a network issue or the details being unavailable on the server. Please check your connection and try again.")
								)
							).accessibleLabel("The cat image is not available, this might be due to a network issue or the image being unavailable on the server.")
						}
					} else {
						CatInfoView(
							viewModel: CatInfoViewModel(
								details: viewModel.catDetails
							)
						)
						.setAccessibilityIdentifier("CatInfoView")
						.combineAccessibilityElements()
						.accessibleLabel("These are the cat details: \(viewModel.accessibleCatDetails)")
					}
				}
				.background(theme.backgroundColor)
				.scrollContentBackground(.hidden)
				.listSectionSpacing(theme.basePadding)
				.navigationTitle("Cat Details")
			}
		}.onAppear {
			viewModel.handleData()
		}
	}
}
