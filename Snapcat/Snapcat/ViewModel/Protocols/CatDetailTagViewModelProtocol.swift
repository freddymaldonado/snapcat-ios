//
//  CatDetailTagViewModelProtocol.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 9/7/24.
//

import Foundation

protocol CatDetailTagViewModelProtocol: ObservableObject {
	var tags: [String]? { get set }
	var hasTags: Bool { get }
	var noTagsText: String { get }
}
