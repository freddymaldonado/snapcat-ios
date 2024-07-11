//
//  CatMediaViewModelProtocol.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 9/7/24.
//

import Foundation
import SDWebImageSwiftUI

protocol CatMediaViewModelProtocol: ObservableObject {
	var error: NetworkError? { get set }
	var url: URL? { get }
	var size: CGFloat? { get }
	var playbackMode: SDAnimatedImagePlaybackMode { get }
	var scaledToFit: Bool { get }
	var handleFailure: ((Error) -> Void)? { get }
}
