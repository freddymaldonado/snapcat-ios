//
//  CatSettingsViewUITests.swift
//  SnapcatUITests
//
//  Created by Freddy Maldonado Pereyra on 10/7/24.
//

import Foundation
import Quick
import Nimble
import XCTest
@testable import Snapcat

class CatSettingsViewUITests: QuickSpec {
	
	override open class func spec() {
		var app: XCUIApplication!
		
		lazy var descendants = app.descendants(matching: .any)
		
		beforeEach {
			app = XCUIApplication()
			app.launch()
			
			let settingsButton = app.navigationBars.buttons["Settings"]
			expect(settingsButton.exists).to(beTrue())
			settingsButton.tap()
		}
		
		describe("CatSettingsView") {
			context("when the view is loaded") {
				it("should toggle dark mode") {
					let darkModeToggle = app.switches["ThemeToggle"]					
					expect(darkModeToggle.exists).to(beTrue())

					darkModeToggle.switches.firstMatch.tap()

					sleep(1)

					expect(darkModeToggle.value as? String).toEventually(equal("1"), timeout: .seconds(5))
					
					sleep(1)

					darkModeToggle.switches.firstMatch.tap()
					
					expect(darkModeToggle.value as? String).toEventually(equal("0"), timeout: .seconds(5))
				}
			}
		}
	}
}

