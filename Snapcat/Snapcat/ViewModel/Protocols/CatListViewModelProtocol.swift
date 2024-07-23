//
//  CatListViewModelProtocol.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 9/7/24.
//

import Foundation

protocol CatListViewModelProtocol: ObservableObject {
	var cats: [Cat] { get set }
	var isLoading: Bool { get set }
	var error: NetworkError? { get set }
	func fetchCats(limit: Int, skip: Int, tags: [String])
}
