//
//  CatInfoView.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 2/7/24.
//

import Foundation
import SwiftUI

struct CatInfoView: View {
	@EnvironmentObject var theme: CatThemeManager
	var details: [CatInfoRow]
	
	var body: some View {
		Section(header: Text("Info")) {
			ForEach(details, id: \.title) { detail in
				CatInfoRowView(title: detail.title, value: detail.value)
			}
		}
		.listRowBackground(Color.clear)
		.listRowSeparatorTint(Color.gray)
	}
}
