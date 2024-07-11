//
//  CatErrorViewModelProtocol.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 9/7/24.
//

import Foundation

protocol CatErrorViewModelProtocol: ObservableObject {
	var error: NetworkError { get set }
	var errorDescription: String { get }
}
