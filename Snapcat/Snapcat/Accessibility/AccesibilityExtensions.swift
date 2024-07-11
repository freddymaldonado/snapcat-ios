//
//  AccesibilityExtensions.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 9/7/24.
//

import SwiftUI

extension View {
	func accessibleLabel(_ label: String) -> some View {
		self.accessibilityLabel(Text(label))
	}
	
	func accessibleHint(_ hint: String) -> some View {
		self.accessibilityHint(Text(hint))
	}
	
	func accessibleValue(_ value: String) -> some View {
		self.accessibilityValue(Text(value))
	}
	
	func combineAccessibilityElements() -> some View {
		self.accessibilityElement(children: .combine)
	}
	
	func setAccessibilityIdentifier(_ identifier: String) -> some View {
		self.accessibility(identifier: identifier)
	}
	
	func removeAccessibilityImageTrait() -> some View {
		self.accessibilityRemoveTraits(.isImage)
	}
	
	func addAccessibilityButtonTrait() -> some View {
		self.accessibilityAddTraits(.isButton)
	}
}


extension CatInfoRow {
	var accessibilityLabel: String {
		switch value {
			case .string(let stringValue):
				return "\(title): \(stringValue)"
			case .date(let dateValue):
				let formatter = DateFormatter()
				formatter.dateStyle = .medium
				return "\(title): \(formatter.string(from: dateValue))"
		}
	}
}
