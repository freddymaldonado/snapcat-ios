//
//  ViewExtensions.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 2/7/24.
//

import SwiftUI

extension View {
	func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
		background(
			GeometryReader { geometryProxy in
				Color.clear
					.preference(key: SizePreferenceKey.self, value: geometryProxy.size)
			}
		)
		.onPreferenceChange(SizePreferenceKey.self, perform: onChange)
	}
}

private struct SizePreferenceKey: PreferenceKey {
	static var defaultValue: CGSize = .zero
	static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

extension View {
	func applyImageScaling(scaledToFit: Bool) -> some View {
		if scaledToFit {
			return AnyView(self.scaledToFit())
		} else {
			return AnyView(self.scaledToFill())
		}
	}
	
	func applyFrame(size: CGFloat?) -> some View {
		if let size = size {
			return AnyView(self.frame(width: size, height: size))
		} else {
			return AnyView(self)
		}
	}
}
