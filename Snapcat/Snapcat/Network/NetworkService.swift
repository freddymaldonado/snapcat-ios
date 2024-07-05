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
				return "Bad URL: \(reason)"
			case .requestFailed(let reason):
				return "Request failed: \(reason)"
		}
	}
}

protocol NetworkService {
	func fetch<T: Decodable>(url: URL) -> AnyPublisher<T, NetworkError>
}

class URLSessionNetworkService: NetworkService {
	func fetch<T: Decodable>(url: URL) -> AnyPublisher<T, NetworkError> {
		URLSession.shared.dataTaskPublisher(for: url)
			.map { $0.data }
			.decode(type: T.self, decoder: JSONDecoder())
			.mapError { error in NetworkError.requestFailed(reason: error.localizedDescription) }
			.eraseToAnyPublisher()
	}
}
