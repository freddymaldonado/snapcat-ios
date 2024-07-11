//
//  CatListViewModelTests.swift
//  SnapcatTests
//
//  Created by Freddy Maldonado Pereyra on 3/7/24.
//

import Quick
import Nimble
import Combine
@testable import Snapcat
import Foundation

class CatListViewModelSpec: QuickSpec {

	override open class func spec() {
		var viewModel: CatListViewModel!
		var mockRepository: MockCatRepository!
		
		CatListViewModelSpec.beforeEach {
			mockRepository = MockCatRepository()
			viewModel = CatListViewModel(repository: mockRepository)
		}
		
		describe("CatListViewModel Initialization") {
			it("starts with an empty cats array") {
				expect(viewModel.cats).to(beEmpty())
			}
			
			it("starts with isLoading set to true") {
				expect(viewModel.isLoading).to(beTrue())
			}
			
			it("starts with error set to nil") {
				expect(viewModel.error).to(beNil())
			}
			
			it("calls fetchCats on initialization") {
				expect(mockRepository.fetchCatsCalled).to(beTrue())
			}
		}
		
		describe("fetchCats Functionality") {
			beforeEach {
				viewModel.fetchCats()
			}
			
			it("sets isLoading to true when called") {
				expect(viewModel.isLoading).to(beTrue())
			}
			
			context("when fetch is successful") {
				it("sets isLoading to false") {
					mockFetchCatsSuccess()
					expect(viewModel.isLoading).toEventually(beFalse())
				}
				
				it("updates cats array") {
					let cats = [Cat(id: "1", tags: [], owner: "", createdAt: Date(), updatedAt: Date(), mimeType: "", size: 1, cachedFileName: nil)]
					mockFetchCatsSuccess(with: cats)
					expect(viewModel.cats).toEventually(equal(cats))
				}
				
				it("sets error to nil") {
					mockFetchCatsSuccess()
					expect(viewModel.error).toEventually(beNil())
				}
			}
			
			context("when fetch fails") {
				it("sets isLoading to false") {
					mockFetchCatsFailure()
					expect(viewModel.isLoading).toEventually(beFalse())
				}
				
				it("does not update cats array") {
					mockFetchCatsFailure()
					expect(viewModel.cats).toEventually(beEmpty())
				}
				
				it("sets the error") {
					let error = NetworkError.requestFailed(reason: "")
					mockFetchCatsFailure(with: error)
					expect(viewModel.error).toEventually(equal(error))
				}
			}
		}
		
		func mockFetchCatsSuccess(with cats: [Cat] = []) {
			mockRepository.fetchCatsSubject.send(cats)
			mockRepository.fetchCatsSubject.send(completion: .finished)
		}
		
		func mockFetchCatsFailure(with error: NetworkError = .requestFailed(reason: "")) {
			mockRepository.fetchCatsSubject.send(completion: .failure(error))
		}
	}
}
