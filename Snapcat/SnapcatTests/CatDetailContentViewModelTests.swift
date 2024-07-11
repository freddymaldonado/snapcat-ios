//
//  CatDetailContentViewModelTests.swift
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

class CatDetailContentViewModelSpec: QuickSpec {
	override open class func spec() {
		describe("CatDetailContentViewModel") {
			var viewModel: CatDetailContentViewModel!
			var observableErrorState: ObservableErrorState!
			
			beforeEach {
				observableErrorState = ObservableErrorState()
				let errorBinding = Binding<NetworkError?>(
					get: { observableErrorState.error },
					set: { observableErrorState.error = $0 }
				)
				viewModel = CatDetailContentViewModel(contentUrl: URL(string: "https://example.com/cat.jpg"), error: errorBinding)
			}
			
			context("when initialized") {
				it("should have the correct initial state") {
					expect(viewModel.contentUrl).to(equal(URL(string: "https://example.com/cat.jpg")))
					expect(viewModel.isFullScreenImagePresented).to(beFalse())
					expect(observableErrorState.error).to(beNil())
				}
			}
			
			context("handleOnTap method") {
				it("should toggle isFullScreenImagePresented") {
					expect(viewModel.isFullScreenImagePresented).to(beFalse())
					viewModel.handleOnTap()
					expect(viewModel.isFullScreenImagePresented).to(beTrue())
					viewModel.handleOnTap()
					expect(viewModel.isFullScreenImagePresented).to(beFalse())
				}
			}
			
			context("error handling") {
				it("should set error when an error occurs") {
					let testError = NetworkError.requestFailed(reason: "Test error")
					observableErrorState.error = testError
					expect(viewModel.error?.localizedDescription).toEventually(equal(testError.localizedDescription))
				}
			}
		}
	}
}
