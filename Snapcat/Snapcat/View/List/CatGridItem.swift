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
	@EnvironmentObject var viewModel: CatListViewModel
	@State private var error: Bool = false
	let cat: Cat
	let imageURL: URL?
	let size: CGFloat
	
	var body: some View {
		ZStack(alignment: .bottom) {
			if error {
				Image(systemName: "network.slash")
					.resizable()
					.applyFrame(size: 80)
					.tint(theme.tintColor)
			} else {
				CatMediaView(
					error: $error,
					url: imageURL,
					size: size,
					playbackMode: .bounce,
					scaledToFit: false
				)
				.overlay(
					VStack {
						HStack {
							CatContentView(
								content: .icon(
									Image(systemName: cat.isGif ? "rectangle.stack.badge.play" : "photo")
								)
							)
							Spacer()
						}
						Spacer()
					}
						.padding(theme.basePadding), alignment: .topLeading
				)
				
				if let previewTags = cat.previewTags {
					CatContentView(content: .text(previewTags))
				}
			}
		}
		.frame(width: size, height: size)
		.cornerRadius(theme.cornerRadius)
	}
}
