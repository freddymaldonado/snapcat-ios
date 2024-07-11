//
//  CatFullScreenView.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 2/7/24.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct CatFullScreenView: View {
	@EnvironmentObject var theme: CatThemeManager
	@Environment(\.presentationMode) var presentationMode
	@ObservedObject var viewModel: CatFullScreenViewModel
	
	var body: some View {
		VStack {
			HStack {
				Button(action: {
					viewModel.dismissView(presentationMode)
				}) {
					Image(systemName: "xmark")
						.foregroundColor(.white)
						.padding()
						.background(CatBlurView(style: theme.lightBackgroundBlurStyle))
						.clipShape(Circle())
				}
				.padding([.top, .leading], theme.basePadding * 2.0)
				
				Spacer()
			}
			
			Spacer()
			
			if let url = viewModel.imageURL {
				WebImage(url: url) { image in
					image
				} placeholder: {
					theme.mediaPlaceholderColor
				}
				.playbackMode(.bounce)
				.resizable()
				.scaledToFit()
				.ignoresSafeArea()
				.overlay(
					Button(action: {
						viewModel.shareImage()
					}) {
						Image(systemName: "square.and.arrow.up")
							.foregroundColor(.white)
							.padding()
							.background(CatBlurView(style: theme.lightBackgroundBlurStyle))
							.clipShape(Circle())
					}
						.padding(),
					alignment: .bottomTrailing
				)
				.sheet(isPresented: $viewModel.isShareSheetPresented, content: {
					CatShareSheetView(activityItems: [url])
				})
			}
			
			Spacer()
		}
		.background(Color.black)
	}
}
