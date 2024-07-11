//
//  CatFullScreenViewModelTests.swift
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

class CatFullScreenViewModelSpec: QuickSpec {
	override open class func spec() {
		describe("CatFullScreenViewModel") {
			var viewModel: CatFullScreenViewModel!
			
			context("when initialized with an imageURL") {
				beforeEach {
					viewModel = CatFullScreenViewModel(imageURL: URL(string: "https://example.com/cat.jpg"))
				}
				
				it("should have the correct initial state") {
					expect(viewModel.imageURL).to(equal(URL(string: "https://example.com/cat.jpg")))
					expect(viewModel.isShareSheetPresented).to(beFalse())
				}
			}
			
			context("when initialized with nil imageURL") {
				beforeEach {
					viewModel = CatFullScreenViewModel(imageURL: nil)
				}
				
				it("should have the correct initial state") {
					expect(viewModel.imageURL).to(beNil())
					expect(viewModel.isShareSheetPresented).to(beFalse())
				}
			}
			
			context("shareImage method") {
				beforeEach {
					viewModel = CatFullScreenViewModel(imageURL: URL(string: "https://example.com/cat.jpg"))
				}
				
				it("should set isShareSheetPresented to true") {
					viewModel.shareImage()
					expect(viewModel.isShareSheetPresented).to(beTrue())
				}
			}
		}
	}
}
