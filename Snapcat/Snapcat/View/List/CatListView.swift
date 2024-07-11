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
			ScrollView {
				VStack {
					LazyVGrid(columns: [
						GridItem(.flexible(), spacing: theme.baseSpacing),
						GridItem(.flexible(), spacing: theme.baseSpacing)
					], spacing: theme.baseSpacing) {
						ForEach(viewModel.cats) { cat in
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
					}
					.padding()
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
		.accentColor(theme.tintColor)
	}
}
