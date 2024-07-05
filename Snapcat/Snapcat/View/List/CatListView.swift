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
	@ObservedObject var viewModel = CatListViewModel()
	
	var body: some View {
		NavigationView {
			ScrollView {
				VStack {
					LazyVGrid(columns: [
						GridItem(.flexible(), spacing: theme.baseSpacing),
						GridItem(.flexible(), spacing: theme.baseSpacing)
					], spacing: theme.baseSpacing) {
						ForEach(viewModel.cats) { cat in
							if let url = cat.contentURL {
								GeometryReader { geometry in
									NavigationLink(destination: CatDetailView(catId: cat.id)) {
										CatGridItem(
											cat: cat,
											imageURL: url,
											size: geometry.size.width
										)
										.environmentObject(viewModel)
									}
									.buttonStyle(CatAnimatedButtonStyle())
								}
								.aspectRatio(1, contentMode: .fit)
							}
						}
					}
					.padding()
				}
			}
			.coordinateSpace(name: "pullToRefresh")
			.navigationTitle("Cats")
			.background(theme.backgroundColor)
			.navigationBarItems(trailing: NavigationLink(destination: CatSettingsView()) {
				Image(systemName: "gearshape.fill")
					.foregroundColor(theme.tintColor)
			})
		}
		.accentColor(theme.tintColor)
	}
}
