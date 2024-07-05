//
//  CatRepository.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 1/7/24.
//

import Foundation
import Combine

protocol CatRepository {
	func fetchCats() -> AnyPublisher<[Cat], NetworkError>
	func fetchCatDetail(id: String) -> AnyPublisher<Cat, NetworkError>
}

class CatRepositoryImpl: CatRepository {
	private let localService: CatAPI
	private let apiService: CatAPI
	
	init(localService: CatAPI, apiService: CatAPI) {
		self.localService = localService
		self.apiService = apiService
	}
	
	func fetchCats() -> AnyPublisher<[Cat], NetworkError> {
		return localService.fetchCats()
	}
	
	func fetchCatDetail(id: String) -> AnyPublisher<Cat, NetworkError> {
		return apiService.fetchCatDetail(id: id)
	}
}
