//
//  CatDetailTagView.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 2/7/24.
//

import Foundation
import SwiftUI

struct CatDetailTagView: View {
	@EnvironmentObject var theme: CatThemeManager
	var tags: [String]?

	var body: some View {
		Section(header: Text("Tags")) {
			if let tags = tags {
				if tags.isEmpty {
					Text("No Tags")
				} else {
					CatTagView(
						data: tags,
						spacing: theme.tagSpacing,
						alignment: .leading
					) { item in
						Text(verbatim: item)
							.font(theme.tagFont)
							.foregroundColor(theme.tagFontColor)
							.padding(theme.basePadding)
							.background(
								RoundedRectangle(cornerRadius: theme.cornerRadius / 2.0)
									.fill(theme.tagBackgroundColor.opacity(theme.tagOpacity))
							)
					}
				}
			}
		}.listRowBackground(Color.clear)
	}
}
