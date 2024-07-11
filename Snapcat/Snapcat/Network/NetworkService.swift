//
//  NetworkService.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 1/7/24.
//

import Foundation
import Combine

enum NetworkError: Error, Equatable {
	case badURL(reason: String)
	case requestFailed(reason: String)
	
	var errorDescription: String {
		switch self {
			case .badURL(let reason):
				return "\(reason)"
			case .requestFailed(let reason):
				return "\(reason)"
		}
	}
	
	func adding(_ info: String) -> NetworkError {
		switch self {
			case .badURL(let reason):
				return .badURL(reason: info + " " + reason)
			case .requestFailed(let reason):
				return .requestFailed(reason: info + " " + reason)
		}
	}
}

protocol NetworkService {
	func fetch<T: Decodable>(url: URL) -> AnyPublisher<T, NetworkError>
}

class URLSessionNetworkService: NetworkService {
	
	init() {
		let cacheSizeMemory = 50 * 1024 * 1024
		let cacheSizeDisk = 100 * 1024 * 1024
		let cache = URLCache(memoryCapacity: cacheSizeMemory, diskCapacity: cacheSizeDisk, diskPath: "snapcatCache")
		URLCache.shared = cache
	}
	
	func fetch<T: Decodable>(url: URL) -> AnyPublisher<T, NetworkError> {
		var request = URLRequest(url: url)
		request.cachePolicy = .returnCacheDataElseLoad
		
		return URLSession.shared.dataTaskPublisher(for: request)
			.map { $0.data }
			.decode(type: T.self, decoder: JSONDecoder())
			.mapError { error in NetworkError.requestFailed(reason: error.localizedDescription) }
			.eraseToAnyPublisher()
	}
}
