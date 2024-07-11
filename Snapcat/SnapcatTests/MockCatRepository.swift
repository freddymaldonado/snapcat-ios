//
//  MockCatRepository.swift
//  SnapcatTests
//
//  Created by Freddy Maldonado Pereyra on 3/7/24.
//

import Foundation
import Combine
@testable import Snapcat

class MockCatRepository: CatRepository {
	var cacheImageCalled = false
	var fetchCatsCalled = false
	var fetchCatsSubject = PassthroughSubject<[Cat], NetworkError>()
	var fetchCatDetailsCalled = false
	var fetchCatDetailsSubject = PassthroughSubject<Cat, NetworkError>()
	
	func fetchCats() -> AnyPublisher<[Cat], NetworkError> {
		fetchCatsCalled = true
		return fetchCatsSubject.eraseToAnyPublisher()
	}
	
	func fetchCatDetail(id: String) -> AnyPublisher<Snapcat.Cat, Snapcat.NetworkError> {
		fetchCatDetailsCalled = true
		return fetchCatDetailsSubject.eraseToAnyPublisher()
	}
	
	func cacheImage(for cat: Snapcat.Cat, data: Data, completion: @escaping () -> Void) {
		cacheImageCalled = true
		completion()
	}
}
