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
	@Binding var isFullScreenImagePresented: Bool
	@State private var error: Bool = false
	var contentUrl: URL?
	
	var body: some View {
		Section(header: Text("Content")) {
			if let url = contentUrl {
				ZStack {
					CatMediaView(
						error: $error,
						url: url,
						size: nil,
						playbackMode: .bounce,
						scaledToFit: true
					).onTapGesture {
						isFullScreenImagePresented = true
					}
					.fullScreenCover(isPresented: $isFullScreenImagePresented) {
						CatFullScreenView(imageURL: url)
					}
					
					VStack {
						Spacer()
						HStack {
							Spacer()
							CatContentView(
								content: .icon(
									Image(systemName: "eye.fill")
								)
							)
						}
					}
					.padding(theme.basePadding * 3)
					.allowsHitTesting(false)
				}
			}
		}.listRowBackground(Color.clear)
	}
}
