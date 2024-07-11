//
//  CatAPI.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 1/7/24.
//

import Foundation
import Combine

protocol CatAPI {
	func fetchCats() -> AnyPublisher<[Cat], NetworkError>
	func fetchCatDetail(id: String) -> AnyPublisher<Cat, NetworkError>
}

class CatAPIService: CatAPI {
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
		var urlComponents = URLComponents(string: "https://cataas.com/cat/\(id)")
		let testParameters = CatQueryParameters(json: true)
		urlComponents?.queryItems = testParameters.toQueryItems()
		
		guard let url = urlComponents?.url else {
			return Fail(error: NetworkError.badURL(reason: "Bad URL")).eraseToAnyPublisher()
		}
		
		return networkService.fetch(url: url)
	}
}
