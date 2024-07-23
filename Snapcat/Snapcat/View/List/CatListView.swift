//
//  CatListView.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 1/7/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct CatListView: View {
	@EnvironmentObject var theme: CatThemeManager
	@ObservedObject var viewModel: CatListViewModel
	
	var body: some View {
		NavigationView {
			if viewModel.isLoading {
				ProgressView()
			} else {
				ScrollView {
					VStack {
						if let tags = viewModel.tags {
							ScrollView(.horizontal) {
								HStack {
									ForEach(tags, id: \.self) { tag in
										Button(tag) {
											viewModel.search(tag: tag)
										}
										.padding(theme.basePadding)
										.foregroundColor(theme.tagFontColor)
										.background(theme.tagBackgroundColor.opacity(theme.tagOpacity))
										.cornerRadius(theme.cornerRadius)
										.buttonStyle(CatAnimatedButtonStyle())
									}
								}
							}
							.scrollIndicators(.hidden)
							.padding(theme.basePadding * 2)
						}
						
						if let error = viewModel.error {
							CatErrorView(
								viewModel: CatErrorViewModel(
									error: error
								)
							)
							.padding(theme.basePadding)
						} else {
							LazyVGrid(columns: [
								GridItem(.flexible(), spacing: theme.baseSpacing),
								GridItem(.flexible(), spacing: theme.baseSpacing)
							], spacing: theme.baseSpacing) {
								ForEach(viewModel.cats, id: \.self) { cat in
									GeometryReader { geometry in
										NavigationLink(destination: CatDetailView(viewModel: CatDetailViewModel(catId: cat.id))) {
											CatGridItem(
												viewModel: CatGridItemViewModel(
													size: geometry.size.width,
													cat: cat)
											)
											.accessibleLabel("This is a Cat \(cat.isGif ? "animated image" : "image") with the following tags: \(cat.previewTags ?? "No Tags"), double Tap in a Cat to show details")
										}
										.buttonStyle(CatAnimatedButtonStyle())
									}
									.aspectRatio(1, contentMode: .fit)
								}
								
								if viewModel.isLoading {
									ProgressView()
								} else {
//									Text("Load More")
//										.onAppear {
//											viewModel.loadMoreCats()
//										}
								}
							}
							.padding()
						}
					}
				}
				.coordinateSpace(name: "pullToRefresh")
				.navigationTitle("Cats")
				.navigationBarTitleDisplayMode(.large)
				.background(theme.backgroundColor)
				.navigationBarItems(
					trailing: NavigationLink(destination:
												CatSettingsView(
													viewModel: CatSettingsViewModel(
														isDarkMode: theme.isDarkMode)
												)) {
													Image(systemName: "gearshape.fill")
														.setAccessibilityIdentifier("Settings")
														.foregroundColor(theme.tintColor)
														.accessibleLabel("This is the settings button, from settings you can delete the cache, double tap to open")
												})
			}
		}
		.accentColor(theme.tintColor)
	}
}

