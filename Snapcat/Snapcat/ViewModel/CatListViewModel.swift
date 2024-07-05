//
//  CatListViewModel.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 1/7/24.
//

import Foundation
import Combine
import SwiftUI

class CatListViewModel: ObservableObject {
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
		isLoading = true
		repository.fetchCats()
			.receive(on: DispatchQueue.main)
			.sink(receiveCompletion: { [weak self] completion in
				self?.isLoading = false
				if case .failure(let error) = completion {
					self?.error = error
				}
			}, receiveValue: { [weak self] cats in
				self?.isLoading = false
				self?.cats = cats
			})
			.store(in: &cancellables)
	}
}
