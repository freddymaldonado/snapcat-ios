//
//  CatDetailTagViewModelTests.swift
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

class CatDetailTagViewModelSpec: QuickSpec {
	override open class func spec() {
		describe("CatDetailTagViewModel") {
			var viewModel: CatDetailTagViewModel!
			
			context("when initialized with tags") {
				beforeEach {
					viewModel = CatDetailTagViewModel(tags: ["cute", "fluffy"])
				}
				
				it("should have the correct initial state") {
					expect(viewModel.tags).to(equal(["cute", "fluffy"]))
					expect(viewModel.hasTags).to(beTrue())
					expect(viewModel.noTagsText).to(equal("No Tags"))
				}
			}
			
			context("when initialized with no tags") {
				beforeEach {
					viewModel = CatDetailTagViewModel(tags: [])
				}
				
				it("should have the correct initial state") {
					expect(viewModel.tags).to(beEmpty())
					expect(viewModel.hasTags).to(beFalse())
					expect(viewModel.noTagsText).to(equal("No Tags"))
				}
			}
			
			context("when initialized with nil tags") {
				beforeEach {
					viewModel = CatDetailTagViewModel(tags: nil)
				}
				
				it("should have the correct initial state") {
					expect(viewModel.tags).to(beNil())
					expect(viewModel.hasTags).to(beFalse())
					expect(viewModel.noTagsText).to(equal("No Tags"))
				}
			}
		}
	}
}
