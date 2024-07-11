//
//  CatMediaViewModel.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 8/7/24.
//

import Foundation
import Combine
import SwiftUI
import SDWebImageSwiftUI

class CatMediaViewModel: CatMediaViewModelProtocol {
	@Binding var error: NetworkError?
	let url: URL?
	let size: CGFloat?
	let playbackMode: SDAnimatedImagePlaybackMode
	let scaledToFit: Bool
	var handleFailure: ((Error) -> Void)?
	private var cat: Cat?
	private let repository: CatRepository
	
	
	init(cat: Cat?, repository: CatRepository = AppRepository.shared, error: Binding<NetworkError?>, url: URL?, size: CGFloat?, playbackMode: SDAnimatedImagePlaybackMode, scaledToFit: Bool) {
		self.cat = cat
		self.repository = repository
		self._error = error
		self.url = url
		self.size = size
		self.playbackMode = playbackMode
		self.scaledToFit = scaledToFit
		self.handleFailure = { [weak self] error in
			guard let self = self else { return }
			DispatchQueue.main.async {
				self.error = .requestFailed(reason: error.localizedDescription)
			}
		}
	}
	
	func cacheContent(data: Data?){
		if let cat = self.cat, let data = data {
			self.repository.cacheImage(for: cat, data: data) {
				print("Image Cached")
			}
		}
	}
}
