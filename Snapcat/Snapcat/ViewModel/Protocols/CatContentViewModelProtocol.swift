//
//  CatContentViewModelProtocol.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 9/7/24.
//

import Foundation

protocol CatContentViewModelProtocol: ObservableObject {
	var content: CatContent { get set }
}
