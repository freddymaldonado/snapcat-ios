//
//  SnapcatUITests.swift
//  SnapcatUITests
//
//  Created by Freddy Maldonado Pereyra on 1/7/24.
//

import Quick
import Nimble
import XCTest

class CatListViewUITests: QuickSpec {
	
	override open class func spec() {
		var app: XCUIApplication!
		
		beforeEach {
			app = XCUIApplication()
			app.launch()
		}
		
		describe("CatListView") {
			it("loads the navigation title") {
				expect(app.navigationBars["Cats"].exists).to(beTrue())
			}
			
			it("has a settings button") {
				expect(app.navigationBars["Cats"].buttons["gearshape.fill"].exists).to(beTrue())
			}
			
			it("loads the cats grid") {
				expect(app.scrollViews.otherElements.children(matching: .other).element(boundBy: 0).exists).to(beTrue())
			}
		}
		
		describe("Navigation") {
			it("navigates to settings view") {
				app.navigationBars["Cats"].buttons["gearshape.fill"].tap()
				expect(app.navigationBars["Settings"].exists).to(beTrue())
			}
			
			it("navigates to cat detail view") {
				let firstCat = app.scrollViews.otherElements.children(matching: .other).element(boundBy: 0)
				expect(firstCat.exists).to(beTrue())
				firstCat.tap()
				expect(app.navigationBars["Cat Details"].exists).to(beTrue())
			}
		}
	}
}
