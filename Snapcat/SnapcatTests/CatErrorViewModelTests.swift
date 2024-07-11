//
//  CatErrorViewModelTests.swift
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

class CatErrorViewModelSpec: QuickSpec {
	override open class func spec() {
		describe("CatErrorViewModel") {
			var viewModel: CatErrorViewModel!
			
			context("when initialized with an error") {
				beforeEach {
					let error = Snapcat.NetworkError.requestFailed(reason: "Test error")
					viewModel = CatErrorViewModel(error: error)
				}
				
				it("should have the correct initial state") {
					expect(viewModel.error).to(equal(Snapcat.NetworkError.requestFailed(reason: "Test error")))
					expect(viewModel.errorDescription).to(equal("Test error"))
				}
			}
			
			context("when error is updated") {
				beforeEach {
					let error = Snapcat.NetworkError.requestFailed(reason: "Initial error")
					viewModel = CatErrorViewModel(error: error)
					viewModel.error = Snapcat.NetworkError.requestFailed(reason: "Updated error")
				}
				
				it("should update the error description") {
					expect(viewModel.error).to(equal(Snapcat.NetworkError.requestFailed(reason: "Updated error")))
					expect(viewModel.errorDescription).to(equal("Updated error"))
				}
			}
		}
	}
}
