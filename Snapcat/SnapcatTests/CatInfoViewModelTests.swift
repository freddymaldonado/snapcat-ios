//
//  CatInfoViewModelTests.swift
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

class CatInfoViewModelSpec: QuickSpec {
	override open class func spec() {
		describe("CatInfoViewModel") {
			var viewModel: CatInfoViewModel!
			
			context("when initialized with details") {
				beforeEach {
					let details = [
						CatInfoRow(title: "Name", value: .string("Whiskers")),
						CatInfoRow(title: "Age", value: .string("2 years")),
						CatInfoRow(title: "Breed", value: .string("Siamese"))
					]
					viewModel = CatInfoViewModel(details: details)
				}
				
				it("should have the correct initial state") {
					expect(viewModel.details).to(equal([
						CatInfoRow(title: "Name", value: .string("Whiskers")),
						CatInfoRow(title: "Age", value: .string("2 years")),
						CatInfoRow(title: "Breed", value: .string("Siamese"))
					]))
				}
			}
			
			context("when initialized with empty details") {
				beforeEach {
					viewModel = CatInfoViewModel(details: [])
				}
				
				it("should have the correct initial state") {
					expect(viewModel.details).to(beEmpty())
				}
			}
		}
	}
}
