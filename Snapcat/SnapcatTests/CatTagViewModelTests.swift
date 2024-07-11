//
//  CatTagViewModelTests.swift
//  SnapcatTests
//
//  Created by Freddy Maldonado Pereyra on 10/7/24.
//

import Quick
import Nimble
import Combine
import SwiftUI
@testable import Snapcat

class CatTagViewModelSpec: QuickSpec {
	override open class func spec() {
		describe("CatTagViewModel") {
			var viewModel: CatTagViewModel<[String], Text>!
			
			beforeEach {
				let data = ["Tag1", "Tag2", "Tag3"]
				viewModel = CatTagViewModel(data: data, spacing: 5, alignment: .leading) { Text($0) }
			}
			
			context("when initialized") {
				it("should have the correct initial state") {
					expect(viewModel.availableWidth).to(equal(10))
					expect(viewModel.elementsSize).to(beEmpty())
					expect(viewModel.data).to(equal(["Tag1", "Tag2", "Tag3"]))
					expect(viewModel.spacing).to(equal(5))
					expect(viewModel.alignment).to(equal(.leading))
				}
			}
			
			context("computeRows method") {
				it("should correctly compute rows based on available width and element sizes") {
					viewModel.updateAvailableWidth(size: CGSize(width: 100, height: 1))
					viewModel.updateElementSize(element: "Tag1", size: CGSize(width: 30, height: 10))
					viewModel.updateElementSize(element: "Tag2", size: CGSize(width: 40, height: 10))
					viewModel.updateElementSize(element: "Tag3", size: CGSize(width: 50, height: 10))
					
					let rows = viewModel.computeRows()
					expect(rows).to(equal([["Tag1", "Tag2"], ["Tag3"]]))
				}
			}
			
			context("updateElementSize method") {
				it("should update the size of a specific element") {
					viewModel.updateElementSize(element: "Tag1", size: CGSize(width: 30, height: 10))
					expect(viewModel.elementsSize["Tag1"]).to(equal(CGSize(width: 30, height: 10)))
				}
			}
			
			context("updateAvailableWidth method") {
				it("should update the available width") {
					viewModel.updateAvailableWidth(size: CGSize(width: 200, height: 1))
					expect(viewModel.availableWidth).to(equal(200))
				}
			}
		}
	}
}
