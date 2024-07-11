//
//  CatFullScreenViewModelProtocol.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 9/7/24.
//

import Foundation
import SwiftUI

protocol CatFullScreenViewModelProtocol: ObservableObject {
	var isShareSheetPresented: Bool { get set }
	var imageURL: URL? { get set }
	func shareImage()
	func dismissView(_ presentationMode: Binding<PresentationMode>)
}
