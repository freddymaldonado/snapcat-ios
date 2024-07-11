//
//  CatTagViewModel.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 8/7/24.
//

import Foundation
import SwiftUI

class CatTagViewModel<Data: Collection, Content: View>: ObservableObject, CatTagViewModelProtocol where Data.Element: Hashable {
	@Published var availableWidth: CGFloat = 10
	@Published var elementsSize: [Data.Element: CGSize] = [:]
	
	let data: Data
	let spacing: CGFloat
	let alignment: HorizontalAlignment
	let content: (Data.Element) -> Content
	
	init(data: Data, spacing: CGFloat, alignment: HorizontalAlignment, content: @escaping (Data.Element) -> Content) {
		self.data = data
		self.spacing = spacing
		self.alignment = alignment
		self.content = content
	}
	
	func computeRows() -> [[Data.Element]] {
		var rows: [[Data.Element]] = [[]]
		var currentRow = 0
		var remainingWidth = availableWidth
		
		for element in data {
			let elementSize = elementsSize[element, default: CGSize(width: availableWidth, height: 1)]
			
			if remainingWidth - (elementSize.width + spacing) >= 0 {
				rows[currentRow].append(element)
			} else {
				currentRow += 1
				rows.append([element])
				remainingWidth = availableWidth
			}
			
			remainingWidth -= (elementSize.width + spacing)
		}
		
		return rows
	}
	
	func updateElementSize(element: Data.Element, size: CGSize) {
		elementsSize[element] = size
	}
	
	func updateAvailableWidth(size: CGSize) {
		availableWidth = size.width
	}
}
