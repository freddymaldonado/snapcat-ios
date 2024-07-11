//
//  CatGridItemViewModelTests.swift
//  SnapcatTests
//
//  Created by Freddy Maldonado Pereyra on 10/7/24.
//

import Foundation
import Quick
import Nimble
import Combine
@testable import Snapcat

class CatGridItemViewModelSpec: QuickSpec {
	override open class func spec() {
		describe("CatGridItemViewModel") {
			var viewModel: CatGridItemViewModel!
			var cat: Cat!
			
			beforeEach {
				cat = Cat(id: "1", tags: ["cute", "fluffy"], owner: "owner", createdAt: nil, updatedAt: nil, mimeType: "image/jpeg", size: nil, cachedFileName: "https://example.com/cat.jpg")
				viewModel = CatGridItemViewModel(size: 100, cat: cat)
			}
			
			context("when initialized") {
				it("should have the correct initial state") {
					expect(viewModel.size).to(equal(100))
					expect(viewModel.cat).to(equal(cat))
					expect(viewModel.error).to(beNil())
				}
				
				it("should return the correct contentUrl") {
					expect(viewModel.contentUrl).to(equal(cat.contentURL))
				}
				
				it("should return the correct previewTags") {
					expect(viewModel.previewTags).to(equal(cat.previewTags))
				}
				
				it("should return the correct typeIcon for a non-gif cat") {
					expect(viewModel.typeIcon).to(equal("photo"))
				}
				
				it("should return the correct typeIcon for a gif cat") {
					let gifCat = Cat(id: "1", tags: ["cute", "fluffy"], owner: "owner", createdAt: nil, updatedAt: nil, mimeType: "image/gif", size: nil, cachedFileName: "https://example.com/cat.gif")
					let gifViewModel = CatGridItemViewModel(size: 100, cat: gifCat)
					expect(gifViewModel.typeIcon).to(equal("rectangle.stack.badge.play"))
				}
				
				it("should return a default typeIcon when cat is nil") {
					let nilCatViewModel = CatGridItemViewModel(size: 100, cat: nil)
					expect(nilCatViewModel.typeIcon).to(equal("camera.metering.unknown"))
				}
			}
		}
	}
}
