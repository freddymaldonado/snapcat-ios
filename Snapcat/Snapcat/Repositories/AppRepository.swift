//
//  AppRepository.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 1/7/24.
//

import Foundation

class AppRepository {
	static let shared: CatRepository = {
		let networkService = URLSessionNetworkService()
		let localService = CatAPIService(networkService: networkService)
		let apiService = CatAPIService(networkService: networkService)
		return CatRepositoryImpl(localService: localService, apiService: apiService)
	}()
}
