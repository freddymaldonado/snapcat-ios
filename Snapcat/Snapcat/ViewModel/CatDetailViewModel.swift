//
//  CatDetailViewModel.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 1/7/24.
//

import Foundation
import Combine
import SwiftUI

class CatDetailViewModel: CatDetailViewModelProtocol {
	@Published var cat: Cat? = nil
	@Published var isLoading = false
	@Published var detailError: NetworkError?
	@Published var isFullScreenImagePresented = false
	@Published var contentError: NetworkError?
	
	private var cancellables = Set<AnyCancellable>()
	private let repository: CatRepository
	private var catId: String
	
	init(isFullScreenImagePresented: Bool = false, contentError: NetworkError? = nil, catId: String, repository: CatRepository = AppRepository.shared) {
		self.repository = repository
		self.catId = catId
	}
	
	func handleData(){
		fetchCatDetail(id: catId, parameters: nil)
	}
	
	func fetchCatDetail(id: String, parameters: CatQueryParameters?) {
		CatAnalyticsManager.startTrace(trace: .catDetailsLoad)
		CatAnalyticsManager.setValue("loading",
									 forAttribute: "fetch_cat_detail",
									 onTrace: .catDetailsLoad)
		isLoading = true
		repository.fetchCatDetail(id: id)
			.receive(on: DispatchQueue.main)
			.sink(receiveCompletion: { [weak self] completion in
				guard let self = self else { return }
				DispatchQueue.main.async {
					self.isLoading = false
					if case .failure(let error) = completion {
						self.detailError = error
						CatAnalyticsManager.setValue(error.errorDescription,
													 forAttribute: "fetch_cat_detail",
													 onTrace: .catDetailsLoad)
					}
					CatAnalyticsManager.stopTrace(trace: .catDetailsLoad)
				}
			}, receiveValue: { [weak self] cat in
				guard let self = self else { return }
				DispatchQueue.main.async {
					self.isLoading = false
					self.cat = cat
					CatAnalyticsManager.setValue(self.accessibleCatDetails.joined(separator: " "),forAttribute: "fetch_cat_detail", onTrace: .catDetailsLoad)
					CatAnalyticsManager.stopTrace(trace: .catDetailsLoad)
				}
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
	
	var accessibleTags: [String] {
		guard let tags = tags else { return [] }
		return tags.map { $0 }
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
	
	var accessibleCatDetails: [String] {
		return catDetails.map { $0.accessibilityLabel }
	}
}
