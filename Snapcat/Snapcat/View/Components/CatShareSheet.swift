//
//  CatShareSheetView.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 2/7/24.
//

import Foundation
import SwiftUI

struct CatShareSheetView: UIViewControllerRepresentable {
	var activityItems: [Any]
	
	func makeUIViewController(context: Context) -> UIActivityViewController {
		return UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
	}
	
	func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
