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
	func fetchCats(limit: Int, skip: Int, tags: [String]) -> AnyPublisher<[Cat], NetworkError>
	func fetchTags() -> AnyPublisher<[String], NetworkError>
	func fetchCatDetail(id: String) -> AnyPublisher<Cat, NetworkError>
}

extension CatAPI {
	func fetchCats() -> AnyPublisher<[Cat], NetworkError> {
		return Fail(error: NetworkError.badURL(reason: "Method not implemented")).eraseToAnyPublisher()
	}
	
	func fetchTags() -> AnyPublisher<[String], NetworkError> {
		return Fail(error: NetworkError.badURL(reason: "Method not implemented")).eraseToAnyPublisher()
	}
	
	func fetchCatDetail(id: String) -> AnyPublisher<Cat, NetworkError> {
		return Fail(error: NetworkError.badURL(reason: "Method not implemented")).eraseToAnyPublisher()
	}
	
	func fetchCats(limit: Int, skip: Int, tags: [String]) -> AnyPublisher<[Cat], NetworkError> {
		return Fail(error: NetworkError.badURL(reason: "Method not implemented")).eraseToAnyPublisher()
	}
}

class CatAPIService: CatAPI {
	private let networkService: NetworkService
	
	init(networkService: NetworkService) {
		self.networkService = networkService
	}
	
	func fetchCats() -> AnyPublisher<[Cat], NetworkError> {
		guard let url = URL(string: "https://cataas.com/api/cats") else {
			return Fail(error: NetworkError.badURL(reason: "Bad Url")).eraseToAnyPublisher()

		}
		
		return networkService.fetch(url: url)
	}
	
	func fetchCats(limit: Int, skip: Int, tags: [String]) -> AnyPublisher<[Cat], NetworkError> {
		var components = URLComponents(string: "https://cataas.com/api/cats")
		var queryItems = [
			URLQueryItem(name: "limit", value: "\(limit)"),
			URLQueryItem(name: "skip", value: "\(skip)")
		]
		
		if !tags.isEmpty {
			let tagsValue = tags.joined(separator: ",")
			queryItems.append(URLQueryItem(name: "tags", value: tagsValue))
		}
		
		components?.queryItems = queryItems
		
		guard let url = components?.url else {
			return Fail(error: NetworkError.badURL(reason: "Bad URL")).eraseToAnyPublisher()
		}

		return networkService.fetch(url: url)
	}
	
	func fetchTags() -> AnyPublisher<[String], NetworkError> {
		guard let url = URL(string: "https://cataas.com/api/tags") else {
			return Fail(error: NetworkError.badURL(reason: "Bad Url")).eraseToAnyPublisher()
			
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
