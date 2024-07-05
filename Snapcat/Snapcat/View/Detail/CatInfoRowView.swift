//
//  CatInfoRowView.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 2/7/24.
//

import SwiftUI

struct CatInfoRow: Equatable {
	static func == (lhs: CatInfoRow, rhs: CatInfoRow) -> Bool {
		return lhs.title == rhs.title && lhs.value == rhs.value
	}
	
	var title: String
	var value: CatInfoRowValue
}

enum CatInfoRowValue: Equatable {
	case string(String)
	case date(Date)
	
	static func == (lhs: CatInfoRowValue, rhs: CatInfoRowValue) -> Bool {
		switch (lhs, rhs) {
			case (.string(let lhsValue), .string(let rhsValue)):
				return lhsValue == rhsValue
			case (.date(let lhsValue), .date(let rhsValue)):
				return lhsValue == rhsValue
			default:
				return false
		}
	}
}

struct CatInfoRowView: View {
	@EnvironmentObject var theme: CatThemeManager
	var title: String
	var value: CatInfoRowValue
	
	var body: some View {
		HStack {
			Text(title)
				.font(theme.primaryFont)
				.foregroundColor(theme.primaryFontColorLight)
			Spacer()
			switch value {
				case .string(let stringValue):
					Text(stringValue)
						.font(theme.secondaryFont)
						.foregroundColor(theme.secondaryFontColorLight)
				case .date(let dateValue):
					Text(dateValue, style: .date)
						.font(theme.secondaryFont)
						.foregroundColor(theme.secondaryFontColorLight)
			}
		}
	}
}
