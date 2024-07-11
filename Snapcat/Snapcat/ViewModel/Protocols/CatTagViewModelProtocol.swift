//
//  CatTagViewModelProtocol.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 9/7/24.
//

import Foundation
import SwiftUI

protocol CatTagViewModelProtocol: ObservableObject {
	associatedtype Data: Collection where Data.Element: Hashable
	var availableWidth: CGFloat { get set }
	var elementsSize: [Data.Element: CGSize] { get set }
	var data: Data { get }
	var spacing: CGFloat { get }
	var alignment: HorizontalAlignment { get }
	func computeRows() -> [[Data.Element]]
	func updateElementSize(element: Data.Element, size: CGSize)
	func updateAvailableWidth(size: CGSize)
}
