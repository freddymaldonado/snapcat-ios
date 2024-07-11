//
//  CatInfoRowViewModelTests.swift
//  SnapcatTests
//
//  Created by Freddy Maldonado Pereyra on 10/7/24.
//

import Foundation
import Quick
import Nimble
import Combine
import SwiftUI
@testable import Snapcat

class CatInfoRowViewModelSpec: QuickSpec {
	override open class func spec() {
		describe("CatInfoRowViewModel") {
			var viewModel: CatInfoRowViewModel!
			
			context("when initialized with a string value") {
				beforeEach {
					viewModel = CatInfoRowViewModel(title: "Name", value: .string("Whiskers"))
				}
				
				it("should have the correct initial state") {
					expect(viewModel.title).to(equal("Name"))
					expect(viewModel.value).to(equal(CatInfoRowValue.string("Whiskers")))
					expect(viewModel.formattedValue).to(equal("Whiskers"))
				}
			}
			
			context("when initialized with a date value") {
				beforeEach {
					let date = Date(timeIntervalSince1970: 0)
					viewModel = CatInfoRowViewModel(title: "Birthday", value: .date(date))
				}
				
				it("should have the correct initial state") {
					expect(viewModel.title).to(equal("Birthday"))
					expect(viewModel.value).to(equal(CatInfoRowValue.date(Date(timeIntervalSince1970: 0))))
					
					let formatter = DateFormatter()
					formatter.dateStyle = .medium
					expect(viewModel.formattedValue).to(equal(formatter.string(from: Date(timeIntervalSince1970: 0))))
				}
			}
			
			context("when title is updated") {
				beforeEach {
					viewModel = CatInfoRowViewModel(title: "Name", value: .string("Whiskers"))
				}
				
				it("should reflect the updated title") {
					viewModel.title = "Nickname"
					expect(viewModel.title).to(equal("Nickname"))
				}
			}
			
			context("when value is updated to a string") {
				beforeEach {
					viewModel = CatInfoRowViewModel(title: "Name", value: .string("Whiskers"))
				}
				
				it("should reflect the updated string value") {
					viewModel.value = .string("Fluffy")
					expect(viewModel.value).to(equal(CatInfoRowValue.string("Fluffy")))
					expect(viewModel.formattedValue).to(equal("Fluffy"))
				}
			}
			
			context("when value is updated to a date") {
				beforeEach {
					viewModel = CatInfoRowViewModel(title: "Name", value: .string("Whiskers"))
				}
				
				it("should reflect the updated date value") {
					let date = Date(timeIntervalSince1970: 1000000)
					viewModel.value = .date(date)
					expect(viewModel.value).to(equal(CatInfoRowValue.date(date)))
					
					let formatter = DateFormatter()
					formatter.dateStyle = .medium
					expect(viewModel.formattedValue).to(equal(formatter.string(from: date)))
				}
			}
		}
	}
}
