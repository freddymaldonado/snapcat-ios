//
//  CatMediaViewModelTests.swift
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
import SDWebImage

class ObservableErrorState: ObservableObject {
	@Published var error: NetworkError? = nil
}

class CatMediaViewModelSpec: QuickSpec {
	override open class func spec() {
		describe("CatMediaViewModel") {
			var viewModel: CatMediaViewModel!
			var cat: Cat!
			var repository: MockCatRepository!
			var observableErrorState: ObservableErrorState!

			beforeEach {
				repository = MockCatRepository()
				cat = Cat(id: "1", tags: ["cute", "fluffy"], owner: "owner", createdAt: nil, updatedAt: nil, mimeType: "image/jpeg", size: nil, cachedFileName: "https://example.com/cat.jpg")
				observableErrorState = ObservableErrorState()
				let errorBinding = Binding<NetworkError?>(
					get: { observableErrorState.error },
					set: { observableErrorState.error = $0 }
				)
				viewModel = CatMediaViewModel(cat: cat, repository: repository, error: errorBinding, url: cat.contentURL, size: 100, playbackMode: .normal, scaledToFit: true)
			}
			
			context("when initialized") {
				it("should have the correct initial state") {
					expect(viewModel.url).to(equal(cat.contentURL))
					expect(viewModel.size).to(equal(100))
					expect(viewModel.playbackMode).to(equal(SDAnimatedImagePlaybackMode.normal))
					expect(viewModel.scaledToFit).to(beTrue())
					expect(observableErrorState.error).to(beNil())
				}
			}
			
			context("handleFailure closure") {
				it("should set error when handleFailure is called") {
					let testError = NSError(domain: "Test", code: 1, userInfo: [NSLocalizedDescriptionKey: "Test error"])
					if let handleFailure = viewModel.handleFailure {
						handleFailure(testError)
					}				
					expect(observableErrorState.error?.localizedDescription).toEventually(equal(NetworkError.requestFailed(reason: "Test error").localizedDescription))
				}
			}
			
			context("cacheContent method") {
				it("should call repository's cacheImage method when cacheContent is called") {
					let testData = Data([0x00, 0x01, 0x02])
					viewModel.cacheContent(data: testData)
					expect(repository.cacheImageCalled).to(beTrue())
				}
			}
		}
	}
}
