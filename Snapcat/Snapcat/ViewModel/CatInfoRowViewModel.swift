//
//  CatInfoRowViewMode.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 8/7/24.
//

import Foundation
import SwiftUI

class CatInfoRowViewModel: CatInfoRowViewModelProtocol {
	@Published var title: String
	@Published var value: CatInfoRowValue
	
	init(title: String, value: CatInfoRowValue) {
		self.title = title
		self.value = value
	}
	
	var formattedValue: String {
		switch value {
			case .string(let stringValue):
				return stringValue
			case .date(let dateValue):
				let formatter = DateFormatter()
				formatter.dateStyle = .medium
				return formatter.string(from: dateValue)
		}
	}
}

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
