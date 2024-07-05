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
	@Binding var error: Bool
	@EnvironmentObject var theme: CatThemeManager
	let url: URL?
	let size: CGFloat?
	let playbackMode: SDAnimatedImagePlaybackMode
	let scaledToFit: Bool
	
	var body: some View {
		WebImage(url: url) { image in
			image
		} placeholder: {
			theme.mediaPlaceholderColor
		}
		.onFailure(perform: { _ in
			error = true
		})
		.playbackMode(playbackMode)
		.resizable()
		.indicator(.activity(style: .automatic))
		.applyImageScaling(scaledToFit: scaledToFit)
		.applyFrame(size: size)
		.clipShape(RoundedRectangle(cornerRadius: theme.basePadding))
	}
}
