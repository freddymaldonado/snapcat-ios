//
//  CatLocalService.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 9/7/24.
//

import Foundation
import Combine

class CatLocalService: CatAPI {
	private let networkService: NetworkService
	
	init(networkService: NetworkService) {
		self.networkService = networkService
	}
	
	func fetchCats() -> AnyPublisher<[Cat], NetworkError> {
		guard let url = Bundle.main.url(forResource: "cats", withExtension: "json") else {
			return Fail(error: NetworkError.badURL(reason: "Resource cats.json not found in the app bundle")).eraseToAnyPublisher()
		}
		
		return networkService.fetch(url: url)
	}
	
	func fetchCatDetail(id: String) -> AnyPublisher<Cat, NetworkError> {
		return fetchCats()
			.tryMap { cats in
				if let cat = cats.first(where: { $0.id == id }) {
					return cat
				} else {
					throw NetworkError.requestFailed(reason: "Cat not found")
				}
			}
			.mapError { error in
				return NetworkError.requestFailed(reason: error.localizedDescription)
			}
			.eraseToAnyPublisher()
	}
}
