//
//  CatListViewModel.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 1/7/24.
//

import Foundation
import Combine
import SwiftUI

class CatListViewModel: CatListViewModelProtocol, ObservableObject {
	@Published var cats: [Cat] = []
	@Published var tags: [String]? = []
	@Published var isLoading = false
	@Published var error: NetworkError?
	@Published var search = [String]()
	
	private var cancellables = Set<AnyCancellable>()
	private let repository: CatRepository
	
	init(repository: CatRepository = AppRepository.shared) {
		self.repository = repository
		fetchTags()
		fetchCats(limit: 10, skip: 0, tags: [])
	}
	
	func fetchCats(limit: Int, skip: Int, tags: [String]) {
		isLoading = true
		repository.fetchCats(limit: limit, skip: skip, tags: tags)
			.receive(on: DispatchQueue.main)
			.sink(receiveCompletion: { [weak self] completion in
				guard let self = self else { return }
				DispatchQueue.main.async {
					self.isLoading = false
					if case .failure(let error) = completion {
						self.error = error
					}
				}
			}, receiveValue: { [weak self] cats in
				guard let self = self else { return }
				DispatchQueue.main.async {
					self.isLoading = false
					self.cats = cats
				}
			})
			.store(in: &cancellables)
	}
	
	func loadMoreCats() {
		isLoading = true
		repository.fetchCats(limit: 10, skip: cats.count, tags: [])
			.receive(on: DispatchQueue.main)
			.sink(receiveCompletion: { [weak self] completion in
				guard let self = self else { return }
				DispatchQueue.main.async {
					self.isLoading = false
					if case .failure(let error) = completion {
						self.error = error
					}
				}
			}, receiveValue: { [weak self] newCats in
				guard let self = self else { return }
				DispatchQueue.main.async {
					self.isLoading = false
					self.cats.append(contentsOf: newCats)
				}
			})
			.store(in: &cancellables)
	}
	
	func fetchTags() {
		isLoading = true
		repository.fetchTags()
			.receive(on: DispatchQueue.main)
			.sink(receiveCompletion: { [weak self] completion in
				guard let self = self else { return }
				DispatchQueue.main.async {
					self.isLoading = false
					if case .failure(let error) = completion {
						self.error = error
					}
				}
			}, receiveValue: { [weak self] tags in
				guard let self = self else { return }
				DispatchQueue.main.async {
					self.isLoading = false
					self.tags = tags
				}
			})
			.store(in: &cancellables)
	}
	
	func searchCats() {
		repository.fetchCats(limit: 10, skip: 0, tags: self.search)
			.receive(on: DispatchQueue.main)
			.sink(receiveCompletion: { [weak self] completion in
				guard let self = self else { return }
				DispatchQueue.main.async {
					if case .failure(let error) = completion {
						self.error = error
					}
				}
			}, receiveValue: { [weak self] cats in
				guard let self = self else { return }
				DispatchQueue.main.async {
					self.cats = cats
					if cats.isEmpty {
						self.error = .requestFailed(reason: "Cats not found with the following tag combination: \(self.search)")
					}
				}
			})
			.store(in: &cancellables)
	}
	
	func search(tag: String) {
		if search.contains(tag) {
			search.removeAll { $0 == tag }
		} else {
			search.append(tag)
		}
		searchCats()
	}
	
	func isTagSelected(_ tag: String) -> Bool {
		return search.contains(tag)
	}
}
