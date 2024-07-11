//
//  CatDetailViewModelProtocol.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 9/7/24.
//

import Foundation

protocol CatDetailViewModelProtocol: ObservableObject {
	var cat: Cat? { get set }
	var isLoading: Bool { get set }
	var detailError: NetworkError? { get set }
	var isFullScreenImagePresented: Bool { get set }
	var contentError: NetworkError? { get set }
	func fetchCatDetail(id: String, parameters: CatQueryParameters?)
	var contentUrl: URL? { get }
	var tags: [String]? { get }
	var catDetails: [CatInfoRow] { get }
}
