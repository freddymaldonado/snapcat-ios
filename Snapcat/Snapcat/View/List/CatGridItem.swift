//
//  CatGridItem.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 2/7/24.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct CatGridItem: View {
	@EnvironmentObject var theme: CatThemeManager
	@ObservedObject var viewModel: CatGridItemViewModel
	@State private var isVisible: Bool = false
	
	var body: some View {
		ZStack(alignment: .bottom) {
			if (viewModel.error != nil) {
				Image(systemName: "network.slash")
					.resizable()
					.applyFrame(size: 80)
					.tint(theme.tintColor)
			} else {
				CatMediaView(
					viewModel: CatMediaViewModel(
						cat: viewModel.cat,
						error: $viewModel.error,
						url: viewModel.contentUrl,
						size: viewModel.size,
						playbackMode: .bounce,
						scaledToFit: false)
				)
				.overlay(
					VStack {
						HStack {
							CatContentView(
								viewModel: CatContentViewModel(
									content: .icon(Image(systemName: viewModel.typeIcon))
								)
							)
							Spacer()
						}
						Spacer()
					}
						.padding(theme.basePadding), alignment: .topLeading
				)
				
				if let previewTags = viewModel.previewTags {
					CatContentView(
						viewModel: CatContentViewModel(
							content: .text(previewTags))
					)
				}
			}
		}
		.frame(width: viewModel.size, height: viewModel.size)
		.cornerRadius(theme.cornerRadius)
		.opacity(isVisible ? 1.0 : 0.0)
		.animation(.easeIn(duration: 0.5), value: isVisible)
		.onAppear {
			withAnimation {
				isVisible = true
			}
		}
	}
}
