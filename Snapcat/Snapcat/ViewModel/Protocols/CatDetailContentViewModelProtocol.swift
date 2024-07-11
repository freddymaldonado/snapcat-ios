//
//  CatDetailContentViewModelProtocol.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 9/7/24.
//

import Foundation

protocol CatDetailContentViewModelProtocol: ObservableObject {
	var isFullScreenImagePresented: Bool { get set }
	var error: NetworkError? { get set }
	var contentUrl: URL? { get }
	func handleOnTap()
}
