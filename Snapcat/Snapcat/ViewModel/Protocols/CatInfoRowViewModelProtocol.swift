//
//  CatInfoRowViewModelProtocol.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 9/7/24.
//

import Foundation

protocol CatInfoRowViewModelProtocol: ObservableObject {
	var title: String { get set }
	var value: CatInfoRowValue { get set }
	var formattedValue: String { get }
}
