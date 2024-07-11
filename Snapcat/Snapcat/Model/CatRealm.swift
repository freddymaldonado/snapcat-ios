//
//  CatRealm.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 9/7/24.
//

import Foundation
import RealmSwift

class CatRealm: Object {
	@Persisted(primaryKey: true) var id: String
	@Persisted var tagsString: String = ""
	@Persisted var owner: String?
	@Persisted var createdAt: Date?
	@Persisted var updatedAt: Date?
	@Persisted var mimeType: String?
	@Persisted var size: Int?
	@Persisted var cachedFileName: String?

	convenience init(from cat: Cat, cachedFileName: String? = nil) {
		self.init()
		self.id = cat.id
		self.tagsString = cat.tags?.joined(separator: ",") ?? ""
		self.owner = cat.owner
		self.createdAt = cat.createdAt
		self.updatedAt = cat.updatedAt
		self.mimeType = cat.mimeType
		self.size = cat.size
		self.cachedFileName = cachedFileName
	}
	
	var tags: [String] {
		return tagsString.split(separator: ",").map { String($0) }
	}
	
	var asCat: Cat {
		return Cat(
			id: id,
			tags: tags,
			owner: owner,
			createdAt: createdAt,
			updatedAt: updatedAt,
			mimeType: mimeType,
			size: size,
			cachedFileName: cachedFileName
		)
	}
}
