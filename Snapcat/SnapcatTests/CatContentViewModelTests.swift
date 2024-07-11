//
//  CatContentViewModelTests.swift
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

class CatContentViewModelSpec: QuickSpec {
	override open class func spec() {
		describe("CatContentViewModel") {
			var viewModel: CatContentViewModel!
			
			context("when initialized with text content") {
				beforeEach {
					viewModel = CatContentViewModel(content: .text("Hello, world!"))
				}
				
				it("should have the correct initial state") {
					if case .text(let text) = viewModel.content {
						expect(text).to(equal("Hello, world!"))
					} else {
						fail("Expected text content")
					}
				}
			}
			
			context("when initialized with icon content") {
				beforeEach {
					viewModel = CatContentViewModel(content: .icon(Image(systemName: "star")))
				}
				
				it("should have the correct initial state") {
					if case .icon(let icon) = viewModel.content {
						expect(icon).to(equal(Image(systemName: "star")))
					} else {
						fail("Expected icon content")
					}
				}
			}
			
			context("when content is updated to text") {
				beforeEach {
					viewModel = CatContentViewModel(content: .text("Initial text"))
				}
				
				it("should reflect the updated text content") {
					viewModel.content = .text("Updated text")
					if case .text(let text) = viewModel.content {
						expect(text).to(equal("Updated text"))
					} else {
						fail("Expected text content")
					}
				}
			}
			
			context("when content is updated to icon") {
				beforeEach {
					viewModel = CatContentViewModel(content: .text("Initial text"))
				}
				
				it("should reflect the updated icon content") {
					viewModel.content = .icon(Image(systemName: "star.fill"))
					if case .icon(let icon) = viewModel.content {
						expect(icon).to(equal(Image(systemName: "star.fill")))
					} else {
						fail("Expected icon content")
					}
				}
			}
		}
	}
}
