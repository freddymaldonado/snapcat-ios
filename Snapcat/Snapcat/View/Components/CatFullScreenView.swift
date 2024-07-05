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
	let imageURL: URL?
	
	@Environment(\.presentationMode) var presentationMode
	@State private var isShareSheetPresented = false
	
	var body: some View {
		VStack {
			HStack {
				Button(action: {
					presentationMode.wrappedValue.dismiss()
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
			
			if let url = imageURL {
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
						isShareSheetPresented = true
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
				.sheet(isPresented: $isShareSheetPresented, content: {
					CatShareSheet(activityItems: [url])
				})
			}
			
			Spacer()
		}
		.background(Color.black)
	}
}
