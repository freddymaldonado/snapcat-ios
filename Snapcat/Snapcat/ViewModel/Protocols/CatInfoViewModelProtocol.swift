//
//  CatInfoViewModelProtocol.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 9/7/24.
//

import Foundation

protocol CatInfoViewModelProtocol: ObservableObject {
	var details: [CatInfoRow] { get set }
}
