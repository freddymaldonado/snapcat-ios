//
//  Cat.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 1/7/24.
//

import Foundation

struct Tag: Identifiable, Equatable, Hashable {
	let id = UUID()
	let tag: String
}

struct Cat: Identifiable, Equatable, Hashable {
	let id: String
	let tags: [String]?
	let owner: String?
	let createdAt: Date?
	let updatedAt: Date?
	let mimeType: String?
	let size: Int?
	let cachedFileName: String?

	var isGif: Bool {
		mimeType == "image/gif"
	}
	
	var contentURL: URL? {
		if let cachedFileName = cachedFileName {
			let fileManager = FileManager.default
			guard let cachesDirectory = fileManager.urls(
				for: .documentDirectory, 
				in: .userDomainMask
			).first else {
				return nil
			}
			
			return cachesDirectory.appendingPathComponent(cachedFileName)
		} else {
			return URL(string: "https://cataas.com/cat/\(id)")
		}
	}
	
	var previewTags: String? {
		if let tags = tags, !tags.isEmpty {
			return tags
				.prefix(5)
				.joined(separator: ", ")
				.prefix(30) + (tags.prefix(5).joined(separator: ", ").count > 30 ? "..." : "")
		} else {
			return nil
		}
	}
}

extension Cat: Decodable {
	enum CodingKeys: String, CodingKey {
		case id = "_id"
		case tags
		case owner
		case createdAt
		case updatedAt
		case mimeType = "mimetype"
		case size
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		id = try container.decode(String.self, forKey: .id)
		tags = (try? container.decode([String].self, forKey: .tags))
		owner = try? container.decode(String.self, forKey: .owner)
		
		let dateFormatter = ISO8601DateFormatter()
		dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
		
		if let createdAtString = try? container.decode(String.self, forKey: .createdAt) {
			createdAt = dateFormatter.date(from: createdAtString)
		} else {
			createdAt = nil
		}
		
		if let updatedAtString = try? container.decode(String.self, forKey: .updatedAt) {
			updatedAt = dateFormatter.date(from: updatedAtString)
		} else {
			updatedAt = nil
		}
		
		mimeType = (try? container.decode(String.self, forKey: .mimeType))
		size = (try? container.decode(Int.self, forKey: .size))
		cachedFileName = nil
	}
}
