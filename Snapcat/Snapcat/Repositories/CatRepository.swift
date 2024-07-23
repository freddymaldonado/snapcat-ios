//
//  CatRepository.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 1/7/24.
//

import Foundation
import Combine
import RealmSwift

protocol CatRepository {
	func fetchCats() -> AnyPublisher<[Cat], NetworkError>
	func fetchCats(limit: Int, skip: Int) -> AnyPublisher<[Cat], NetworkError>
	func fetchCats(limit: Int, skip: Int, tags: [String]) -> AnyPublisher<[Cat], NetworkError>
	func fetchTags() -> AnyPublisher<[String], NetworkError>
	func fetchCatDetail(id: String) -> AnyPublisher<Cat, NetworkError>
	func cacheImage(for cat: Cat, data: Data, completion: @escaping () -> Void)
}

extension CatRepository {
	func fetchCats() -> AnyPublisher<[Cat], NetworkError> {
		return Fail(error: NetworkError.badURL(reason: "Method not implemented")).eraseToAnyPublisher()
	}
	
	func fetchCatDetail(id: String) -> AnyPublisher<Cat, NetworkError> {
		return Fail(error: NetworkError.badURL(reason: "Method not implemented")).eraseToAnyPublisher()
	}
	
	func fetchCats(limit: Int, skip: Int) -> AnyPublisher<[Cat], NetworkError> {
		return Fail(error: NetworkError.badURL(reason: "Method not implemented")).eraseToAnyPublisher()
	}
	
	func fetchCats(limit: Int, skip: Int, tags: [String]) -> AnyPublisher<[Cat], NetworkError> {
		return Fail(error: NetworkError.badURL(reason: "Method not implemented")).eraseToAnyPublisher()
	}
	
	func fetchTags() -> AnyPublisher<[String], NetworkError> {
		return Fail(error: NetworkError.badURL(reason: "Method not implemented")).eraseToAnyPublisher()
	}
	
	func cacheImage(for cat: Cat, data: Data, completion: @escaping () -> Void) {
		completion()
	}
}

class CatRepositoryImpl: CatRepository {
	private let localService: CatAPI
	private let apiService: CatAPI
	private let realm: Realm
	private var cancellables = Set<AnyCancellable>()

	init(localService: CatAPI, apiService: CatAPI, realm: Realm) {
		self.localService = localService
		self.apiService = apiService
		self.realm = realm
	}
	
	func fetchCats() -> AnyPublisher<[Cat], NetworkError> {
		return Future<[Cat], NetworkError> { [weak self] promise in
			DispatchQueue.global(qos: .background).sync {
				guard let self = self else {
					promise(.failure(.requestFailed(reason: "Unknown")))
					return
				}
				let cachedCats = self.realm.objects(CatRealm.self)
				if !cachedCats.isEmpty {
					let cats = cachedCats.map { $0.asCat }
					promise(.success(Array(cats)))
				} else {
					self.apiService.fetchCats()
						.sink(receiveCompletion: { completion in
							if case let .failure(error) = completion {
								promise(.failure(error))
							}
						}, receiveValue: { cats in
							self.saveCatsToCache(cats)
							promise(.success(cats))
						})
						.store(in: &self.cancellables)
				}
			}
		}
		.receive(on: DispatchQueue.main)
		.eraseToAnyPublisher()
	}
	
	func fetchCats(limit: Int, skip: Int, tags: [String]) -> AnyPublisher<[Cat], NetworkError> {
		return Future<[Cat], NetworkError> { [weak self] promise in
			DispatchQueue.global(qos: .background).sync {
				guard let self = self else {
					promise(.failure(.requestFailed(reason: "Unknown")))
					return
				}
				
				self.apiService.fetchCats(limit: limit, skip: skip, tags: tags)
						.sink(receiveCompletion: { completion in
							if case let .failure(error) = completion {
								promise(.failure(error))
							}
						}, receiveValue: { cats in
							self.saveCatsToCache(cats)
							promise(.success(cats))
						})
						.store(in: &self.cancellables)
			}
		}
		.receive(on: DispatchQueue.main)
		.eraseToAnyPublisher()
	}
	
	func fetchTags() -> AnyPublisher<[String], NetworkError> {
		return Future<[String], NetworkError> { [weak self] promise in
			DispatchQueue.global(qos: .background).sync {
				guard let self = self else {
					promise(.failure(.requestFailed(reason: "Unknown")))
					return
				}
				
				self.apiService.fetchTags()
					.sink(receiveCompletion: { completion in
						if case let .failure(error) = completion {
							promise(.failure(error))
						}
					}, receiveValue: { cats in
						promise(.success(cats))
					})
					.store(in: &self.cancellables)
			}
		}
		.receive(on: DispatchQueue.main)
		.eraseToAnyPublisher()
	}
	
	func fetchCatDetail(id: String) -> AnyPublisher<Cat, NetworkError> {
		return Future<Cat, NetworkError> { [weak self] promise in
			guard let self = self else {
				promise(.failure(.requestFailed(reason: "Unknown")))
				return
			}
			
			self.apiService.fetchCatDetail(id: id)
				.sink(receiveCompletion: { completion in
					if case let .failure(error) = completion {
						DispatchQueue.main.async {
							self.handleFetchError(id: id, error: error, promise: promise)
						}
					}
				}, receiveValue: { cat in
					DispatchQueue.main.async {
						self.handleFetchSuccess(cat: cat, promise: promise)
					}
				})
				.store(in: &self.cancellables)
		}
		.receive(on: DispatchQueue.main)
		.eraseToAnyPublisher()
	}
	
	private func handleFetchError(id: String, error: NetworkError, promise: @escaping (Result<Cat, NetworkError>) -> Void) {
		DispatchQueue.global(qos: .background).sync {
			if let cachedCat = self.realm.object(ofType: CatRealm.self, forPrimaryKey: id) {
				promise(.success(cachedCat.asCat))
			} else {
				promise(.failure(error))
			}
		}
	}
	
	private func handleFetchSuccess(cat: Cat, promise: @escaping (Result<Cat, NetworkError>) -> Void) {
		DispatchQueue.global(qos: .background).sync {
			let catWithCache: Cat
			if let cachedCat = self.realm.object(ofType: CatRealm.self, forPrimaryKey: cat.id),
			   let cachedFileName = cachedCat.cachedFileName {
				catWithCache = Cat(id: cat.id, tags: cat.tags, owner: cat.owner, createdAt: cat.createdAt, updatedAt: cat.updatedAt, mimeType: cat.mimeType, size: cat.size, cachedFileName: cachedFileName)
			} else {
				catWithCache = Cat(id: cat.id, tags: cat.tags, owner: cat.owner, createdAt: cat.createdAt, updatedAt: cat.updatedAt, mimeType: cat.mimeType, size: cat.size, cachedFileName: nil)
			}
			self.saveCatToCache(catWithCache)
			promise(.success(catWithCache))
		}
	}
	
	func cacheImage(for cat: Cat, data: Data, completion: @escaping () -> Void) {
		guard let mimeType = cat.mimeType, let fileExtension = mimeType.split(separator: "/").last.map(String.init) else {
			completion()
			return
		}
		
		let fileManager = FileManager.default
		guard let cachesDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
			completion()
			return
		}
		
		let fileName = "\(cat.id).\(fileExtension)"
		let fileURL = cachesDirectory.appendingPathComponent(fileName)
		
		do {
			try data.write(to: fileURL)
			
			let catWithCache = Cat(
				id: cat.id,
				tags: cat.tags,
				owner: cat.owner,
				createdAt: cat.createdAt,
				updatedAt: cat.updatedAt,
				mimeType: cat.mimeType,
				size: cat.size,
				cachedFileName: fileName
			)
			saveCatToCache(catWithCache)
			completion()
		} catch {
			print("Failed to write image data to file: \(error.localizedDescription)")
			completion()
		}
	}
	
	private func saveCatToCache(_ cat: Cat) {
		DispatchQueue.global(qos: .background).async {
			do {
				let realm = try Realm()
				let catRealm = CatRealm(from: cat, cachedFileName: cat.cachedFileName)
				try realm.write {
					realm.add(catRealm, update: .modified)
				}
			} catch {
				print("Failed to write cat to Realm: \(error.localizedDescription)")
			}
		}
	}
	
	private func saveCatsToCache(_ cats: [Cat]) {
		DispatchQueue.main.async { [weak self] in
			guard let self = self else { return }
			do {
				try realm.write {
					let catRealms = cats.map { CatRealm(from: $0) }
					self.realm.add(catRealms, update: .modified)
				}
			} catch {
				print("Failed to write cats to Realm: \(error.localizedDescription)")
			}
		}
	}
}
