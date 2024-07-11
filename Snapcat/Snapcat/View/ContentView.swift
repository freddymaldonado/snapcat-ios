//
//  ContentView.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 1/7/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
		CatListView(viewModel: CatListViewModel())
    }
}

#Preview {
    ContentView()
}
