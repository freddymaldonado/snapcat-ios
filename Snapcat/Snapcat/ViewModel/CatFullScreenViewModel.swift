//
//  CatFullScreenViewModel.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 8/7/24.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

class CatFullScreenViewModel: CatFullScreenViewModelProtocol {
	@Published var isShareSheetPresented = false
	var imageURL: URL?
	
	init(imageURL: URL?) {
		self.imageURL = imageURL
	}
	
	func shareImage() {
		isShareSheetPresented = true
	}
	
	func dismissView(_ presentationMode: Binding<PresentationMode>) {
		presentationMode.wrappedValue.dismiss()
	}
}
