//
//  CatQueryParameters.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 1/7/24.
//

import Foundation

//I've included the entire query parameters based on the /cat api to generate
//random cats, so i think is a good idea to define this from the start so that
//adding new features in the future such as generating cats would be easier

//Commented the parameters that are not used in the scope of the project, but leaved
//them there to show the modeling and also will be easier to include the feature in
//the future
struct CatQueryParameters {
//	var type: String?
//	var filter: String?
//	var fit: String?
//	var position: String?
//	var width: Int?
//	var height: Int?
//	var blur: Int?
//	var r: Int?
//	var g: Int?
//	var b: Int?
//	var brightness: Float?
//	var saturation: Float?
//	var hue: Int?
//	var lightness: Int?
//	var html: Bool?
	var json: Bool?
	
	func toQueryItems() -> [URLQueryItem] {
		var queryItems = [URLQueryItem]()
//		if let type = type { queryItems.append(URLQueryItem(name: "type", value: type)) }
//		if let filter = filter { queryItems.append(URLQueryItem(name: "filter", value: filter)) }
//		if let fit = fit { queryItems.append(URLQueryItem(name: "fit", value: fit)) }
//		if let position = position { queryItems.append(URLQueryItem(name: "position", value: position)) }
//		if let width = width { queryItems.append(URLQueryItem(name: "width", value: "\(width)")) }
//		if let height = height { queryItems.append(URLQueryItem(name: "height", value: "\(height)")) }
//		if let blur = blur { queryItems.append(URLQueryItem(name: "blur", value: "\(blur)")) }
//		if let r = r { queryItems.append(URLQueryItem(name: "r", value: "\(r)")) }
//		if let g = g { queryItems.append(URLQueryItem(name: "g", value: "\(g)")) }
//		if let b = b { queryItems.append(URLQueryItem(name: "b", value: "\(b)")) }
//		if let brightness = brightness { queryItems.append(URLQueryItem(name: "brightness", value: "\(brightness)")) }
//		if let saturation = saturation { queryItems.append(URLQueryItem(name: "saturation", value: "\(saturation)")) }
//		if let hue = hue { queryItems.append(URLQueryItem(name: "hue", value: "\(hue)")) }
//		if let lightness = lightness { queryItems.append(URLQueryItem(name: "lightness", value: "\(lightness)")) }
//		if let html = html { queryItems.append(URLQueryItem(name: "html", value: "\(html)")) }
		if let json = json { queryItems.append(URLQueryItem(name: "json", value: "\(json)")) }
		return queryItems
	}
}
