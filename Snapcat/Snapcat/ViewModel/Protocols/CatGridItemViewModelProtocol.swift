//
//  CatGridItemViewModelProtocol.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 9/7/24.
//

import Foundation

protocol CatGridItemViewModelProtocol: ObservableObject {
	var error: NetworkError? { get set }
	var size: CGFloat { get set }
	var contentUrl: URL? { get }
	var previewTags: String? { get }
	var typeIcon: String { get }
}
