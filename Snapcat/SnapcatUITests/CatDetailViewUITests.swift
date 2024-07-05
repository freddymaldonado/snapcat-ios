//
//  CatDetailViewUITests.swift
//  SnapcatUITests
//
//  Created by Freddy Maldonado Pereyra on 3/7/24.
//

import Quick
import Nimble
import XCTest
import SDWebImageSwiftUI
@testable import Snapcat

class CatDetailViewUITests: QuickSpec {
	
	override open class func spec() {
		var app: XCUIApplication!

		lazy var descendants = app.descendants(matching: .any)
		
		beforeEach {
			app = XCUIApplication()
			app.launch()
			
			let firstCat = app.scrollViews.otherElements.children(matching: .other).element(boundBy: 0)
			expect(firstCat.exists).to(beTrue())
			firstCat.tap()
		}
		
		describe("CatDetailView") {
			context("when data is loaded") {
				it("should show the cat info view") {
					sleep(5)
					let contentView = descendants["CatDetailContentView"]
					expect(contentView.exists).toEventually(beTrue(), timeout: .seconds(5))
				}
			}
		}
		
		describe("CatDetailContentView") {
			context("when data is loaded") {
				it("should show the cat media content view") {
					sleep(5)
					let contentView = descendants["CatDetailContentView"]
					expect(contentView.exists).toEventually(beTrue(), timeout: .seconds(5))
				}
			}
		}
		
		describe("CatDetailTagView") {
			context("when data is loaded") {
				it("should show the tags view") {
					sleep(5)
					let contentView = descendants["CatDetailTagView"]
					expect(contentView.exists).toEventually(beTrue(), timeout: .seconds(5))
				}
			}
		}
	}
}
