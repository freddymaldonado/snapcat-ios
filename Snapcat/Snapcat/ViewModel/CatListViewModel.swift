//
//  CatListViewModel.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 1/7/24.
//

import Foundation
import Combine
import SwiftUI

class CatListViewModel: CatListViewModelProtocol {
	@Published var cats: [Cat] = []
	@Published var isLoading = false
	@Published var error: NetworkError?
	
	private var cancellables = Set<AnyCancellable>()
	private let repository: CatRepository
	
	init(repository: CatRepository = AppRepository.shared) {
		self.repository = repository
		fetchCats()
	}
	
	func fetchCats() {
		CatAnalyticsManager.startTrace(trace: .catListLoad)
		CatAnalyticsManager.setValue("loading",
									 forAttribute: "fetch_cats",
									 onTrace: .catListLoad)
		isLoading = true
		repository.fetchCats()
			.receive(on: DispatchQueue.main)
			.sink(receiveCompletion: { [weak self] completion in
				guard let self = self else { return }
				DispatchQueue.main.async {
					self.isLoading = false
					if case .failure(let error) = completion {
						self.error = error
						CatAnalyticsManager.setValue(error.errorDescription,
													 forAttribute: "fetch_cats",
													 onTrace: .catListLoad)
					}
					CatAnalyticsManager.stopTrace(trace: .catListLoad)
				}
			}, receiveValue: { [weak self] cats in
				guard let self = self else { return }
				DispatchQueue.main.async {
					self.isLoading = false
					self.cats = cats
					CatAnalyticsManager.setValue("success, fetched \(cats.count) cats",
												 forAttribute: "fetch_cats",
												 onTrace: .catListLoad)
					CatAnalyticsManager.stopTrace(trace: .catListLoad)
				}
			})
			.store(in: &cancellables)
	}
}
