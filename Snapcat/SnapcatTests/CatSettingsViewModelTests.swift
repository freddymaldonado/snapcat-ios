//
//  CatSettingsViewModelTests.swift
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

class CatSettingsViewModelSpec: QuickSpec {
	override open class func spec() {
		describe("CatSettingsViewModel") {
			var viewModel: CatSettingsViewModel!
			
			context("when initialized with isDarkMode false") {
				beforeEach {
					viewModel = CatSettingsViewModel(isDarkMode: false)
				}
				
				it("should have the correct initial state") {
					expect(viewModel.isDarkMode).to(beFalse())
					expect(viewModel.isAlertPresented).to(beFalse())
				}
			}
			
			context("when initialized with isDarkMode true") {
				beforeEach {
					viewModel = CatSettingsViewModel(isDarkMode: true)
				}
				
				it("should have the correct initial state") {
					expect(viewModel.isDarkMode).to(beTrue())
					expect(viewModel.isAlertPresented).to(beFalse())
				}
			}
		}
	}
}

