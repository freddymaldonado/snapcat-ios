//
//  CatDetailViewModelTests.swift.swift
//  SnapcatTests
//
//  Created by Freddy Maldonado Pereyra on 3/7/24.
//

import Quick
import Nimble
import Combine
@testable import Snapcat
import Foundation

class CatDetailViewModelSpec: QuickSpec {
	override open class func spec() {
		var viewModel: CatDetailViewModel!
		var mockRepository: MockCatRepository!
		
		beforeEach {
			mockRepository = MockCatRepository()
			viewModel = CatDetailViewModel(catId: "1", repository: mockRepository)
		}
		
		describe("CatDetailViewModel Initialization") {
			it("starts with nil cat") {
				expect(viewModel.cat).to(beNil())
			}
			
			it("starts with isLoading set to true") {
				expect(viewModel.isLoading).to(beTrue())
			}

			it("calls fetchCatDetail on initialization") {
				expect(mockRepository.fetchCatDetailsCalled).to(beTrue())
			}
		}
		
		describe("fetchCatDetail Functionality") {
			beforeEach {
				viewModel.fetchCatDetail(id: "1", parameters: nil)
			}
			
			it("sets isLoading to true when called") {
				expect(viewModel.isLoading).to(beTrue())
			}
			
			context("when fetch is successful") {
				it("sets isLoading to false") {
					mockFetchCatDetailSuccess()
					expect(viewModel.isLoading).toEventually(beFalse())
				}
				
				it("updates cat") {
					let cat = Cat(id: "1", tags: [], owner: "", createdAt: Date(), updatedAt: Date(), mimeType: "", size: 1, cachedFileName: nil)
					mockFetchCatDetailSuccess(with: cat)
					expect(viewModel.cat).toEventually(equal(cat))
				}
			}
			
			context("when fetch fails") {
				it("sets isLoading to false") {
					mockFetchCatDetailFailure()
					expect(viewModel.isLoading).toEventually(beFalse())
				}
				
				it("does not update cat") {
					mockFetchCatDetailFailure()
					expect(viewModel.cat).toEventually(beNil())
				}
			}
		}
		
		describe("catDetails Property") {
			it("returns correct details when cat is set") {
				let cat = Cat(id: "1", tags: ["cute"], owner: "John", createdAt: Date(timeIntervalSince1970: 1620000000), updatedAt: Date(timeIntervalSince1970: 1620003600), mimeType: "image/jpeg", size: 10240, cachedFileName: nil)
				mockFetchCatDetailSuccess(with: cat)
				let expectedDetails = [
					CatInfoRow(title: "Size", value: .string("10.00 KB")),
					CatInfoRow(title: "Owner", value: .string("John")),
					CatInfoRow(title: "Created At", value: .date(Date(timeIntervalSince1970: 1620000000))),
					CatInfoRow(title: "Updated At", value: .date(Date(timeIntervalSince1970: 1620003600))),
					CatInfoRow(title: "MimeType", value: .string("image/jpeg")),
					CatInfoRow(title: "ID", value: .string("1"))
				]
				expect(viewModel.catDetails).toEventually(equal(expectedDetails))
			}
			
			it("returns empty details when cat is nil") {
				expect(viewModel.catDetails).to(beEmpty())
			}
		}
		
		func mockFetchCatDetailSuccess(with cat: Cat = Cat(id: "1", tags: [], owner: "", createdAt: Date(), updatedAt: Date(), mimeType: "", size: 1, cachedFileName: nil)) {
			mockRepository.fetchCatDetailsSubject.send(cat)
			mockRepository.fetchCatDetailsSubject.send(completion: .finished)
		}
		
		func mockFetchCatDetailFailure(with error: NetworkError = .requestFailed(reason: "")) {
			mockRepository.fetchCatDetailsSubject.send(completion: .failure(error))
		}
	}
}
