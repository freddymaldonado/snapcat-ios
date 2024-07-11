//
//  CatDetailContentViewModel.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 8/7/24.
//

import Foundation
import SwiftUI

class CatDetailContentViewModel: CatDetailContentViewModelProtocol {
	@Published var isFullScreenImagePresented: Bool = false
	@Binding var error: NetworkError?
	var contentUrl: URL?
	
	init(contentUrl: URL?, error: Binding<NetworkError?>) {
		self.contentUrl = contentUrl
		self._error = error
	}
	
	func handleOnTap(){
		isFullScreenImagePresented.toggle()
	}
}
