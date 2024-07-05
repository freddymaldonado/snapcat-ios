//
//  CatDetailViewModel.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 1/7/24.
//

import Foundation
import Combine
import SwiftUI

class CatDetailViewModel: ObservableObject {
	@Published var cat: Cat?
	@Published var isLoading = false
	@Published var error: NetworkError?
	
	private var cancellables = Set<AnyCancellable>()
	private let repository: CatRepository
	
	init(catId: String, repository: CatRepository = AppRepository.shared) {
		self.repository = repository
		fetchCatDetail(id: catId, parameters: nil)
	}
	
	func fetchCatDetail(id: String, parameters: CatQueryParameters?) {
		isLoading = true
		repository.fetchCatDetail(id: id)
			.receive(on: DispatchQueue.main)
			.sink(receiveCompletion: { [weak self] completion in
				self?.isLoading = false
				if case .failure(let error) = completion {
					self?.error = error
				}
			}, receiveValue: { [weak self] cat in
				self?.isLoading = false
				self?.cat = cat
			})
			.store(in: &cancellables)
	}
	
	private func sizeInKB(_ size: Int?) -> String? {
		guard let size = size else { return nil }
		let sizeInKB = Double(size) / 1024.0
		return String(format: "%.2f KB", sizeInKB)
	}
	
	var contentUrl: URL? {
		return cat?.contentURL
	}
	
	var tags: [String]? {
		return cat?.tags
	}
	
	private var size: String? {
		return sizeInKB(cat?.size)
	}
	
	private var owner: String? {
		return cat?.owner
	}
	
	private var createdAt: Date? {
		return cat?.createdAt
	}
	
	private var updatedAt: Date? {
		return cat?.updatedAt
	}
	
	private var mimeType: String? {
		return cat?.mimeType
	}
	
	private var id: String? {
		return cat?.id
	}
	
	var catDetails: [CatInfoRow] {
		var details = [CatInfoRow]()
		
		if let size = size {
			details.append(CatInfoRow(title: "Size", value: .string(size)))
		}
		
		if let owner = owner {
			details.append(CatInfoRow(title: "Owner", value: .string(owner)))
		}
		
		if let createdAt = createdAt {
			details.append(CatInfoRow(title: "Created At", value: .date(createdAt)))
		}
		
		if let updatedAt = updatedAt {
			details.append(CatInfoRow(title: "Updated At", value: .date(updatedAt)))
		}
		
		if let mimeType = mimeType {
			details.append(CatInfoRow(title: "MimeType", value: .string(mimeType)))
		}
		
		if let id = id {
			details.append(CatInfoRow(title: "ID", value: .string(id)))
		}
		
		return details
	}
}
