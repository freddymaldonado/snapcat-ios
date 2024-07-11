//
//  CatDetailContentView.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 2/7/24.
//

import Foundation
import SwiftUI

struct CatDetailContentView: View {
	@EnvironmentObject var theme: CatThemeManager
	@ObservedObject var viewModel: CatDetailContentViewModel
	
	var body: some View {
		Section(header: Text("Content")) {
				ZStack {
					CatMediaView(
						viewModel: CatMediaViewModel(
							cat: nil,
							error: $viewModel.error,
							url: viewModel.contentUrl,
							size: nil,
							playbackMode: .bounce,
							scaledToFit: true
						)
					)
					.onTapGesture {
						viewModel.handleOnTap()
					}
					.fullScreenCover(isPresented: $viewModel.isFullScreenImagePresented) {
						CatFullScreenView(
							viewModel: CatFullScreenViewModel(
								imageURL: viewModel.contentUrl
							)
						)
					}
					
					VStack {
						Spacer()
						HStack {
							Spacer()
							CatContentView(
								viewModel: CatContentViewModel(
									content: .icon(Image(systemName: "eye.fill"))
								)
							)
						}
					}
					.padding(theme.basePadding * 3)
					.allowsHitTesting(false)
				}
		}
		.listRowBackground(Color.clear)
		.listRowSeparator(.hidden)
	}
}
