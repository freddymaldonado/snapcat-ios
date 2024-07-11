//
//  AppRepository.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 1/7/24.
//

import Foundation
import RealmSwift

class AppRepository {
	static let shared: CatRepository = {
		let realm = try! Realm()
		let networkService = URLSessionNetworkService()
		let localService = CatLocalService(networkService: networkService)
		let apiService = CatAPIService(networkService: networkService)
		
		return CatRepositoryImpl(
			localService: localService,
			apiService: apiService,
			realm: realm
		)
	}()
}
