//
//  CatMediaView.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 2/7/24.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct CatMediaView: View {
	@EnvironmentObject var theme: CatThemeManager
	@ObservedObject var viewModel: CatMediaViewModel
//	@State var loading: Bool = false
	
	var body: some View {
		if let url = viewModel.url {
			if url.isFileURL {
				if FileManager.default.fileExists(atPath: url.path) {
					if let data = try? Data(contentsOf: url) {
						AnimatedImage(data: data)
							.onFailure(perform: viewModel.handleFailure)
							.playbackMode(viewModel.playbackMode)
							.resizable()
							.applyImageScaling(scaledToFit: viewModel.scaledToFit)
							.applyFrame(size: viewModel.size)
							.clipShape(RoundedRectangle(cornerRadius: theme.basePadding))
					} else {
						theme.mediaPlaceholderColor
					}
				} else {
					theme.mediaPlaceholderColor
				}
			} else {
				WebImage(url: url)
					.onSuccess(perform: { _, data, _ in
						viewModel.cacheContent(data: data)
					})
					.onFailure(perform: viewModel.handleFailure)
					.playbackMode(viewModel.playbackMode)
					.resizable()
					.indicator(content: { _, progress in
						CatSpinnerView(progress: progress)
					})
					.applyImageScaling(scaledToFit: viewModel.scaledToFit)
					.applyFrame(size: viewModel.size)
					.clipShape(RoundedRectangle(cornerRadius: theme.basePadding))
			}
		} else {
			theme.mediaPlaceholderColor
		}
	}
}
