//
//  CatTagView.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 2/7/24.
//

// To build the tag view, found inspiration and used this great third party component
// Source: https://github.com/FiveStarsBlog/CodeSamples/blob/main/Flexible-SwiftUI/Flexible/FlexibleView.swift

import Foundation
import SwiftUI

struct CatTagView<Data: Collection, Content: View>: View where Data.Element: Hashable {
	@EnvironmentObject var theme: CatThemeManager
	@ObservedObject var viewModel: CatTagViewModel<Data, Content>
	
	var body: some View {
		ZStack(alignment: Alignment(horizontal: viewModel.alignment, vertical: .center)) {
			Color.clear
				.frame(height: 1)
				.readSize { size in
					viewModel.updateAvailableWidth(size: size)
				}
			
			_CatTagView(viewModel: viewModel)
		}
	}
}

struct _CatTagView<Data: Collection, Content: View>: View where Data.Element: Hashable {
	@ObservedObject var viewModel: CatTagViewModel<Data, Content>
	
	var body: some View {
		VStack(alignment: viewModel.alignment, spacing: viewModel.spacing) {
			ForEach(viewModel.computeRows(), id: \.self) { rowElements in
				HStack(spacing: viewModel.spacing) {
					ForEach(rowElements, id: \.self) { element in
						viewModel.content(element)
							.fixedSize()
							.readSize { size in
								viewModel.updateElementSize(element: element, size: size)
							}
					}
				}
			}
		}
	}
}
