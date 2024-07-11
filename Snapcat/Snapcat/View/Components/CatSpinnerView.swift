//
//  CatSpinnerView.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 10/7/24.
//

import Foundation
import SwiftUI

struct CatSpinnerView: View {
	@EnvironmentObject var theme: CatThemeManager
	@Binding var progress: Double
	
	var body: some View {
		ZStack {
			Circle()
				.stroke(theme.tintColor.opacity(0.3), style: StrokeStyle(lineWidth: 8.0, lineCap: .round, lineJoin: .round))
				.frame(width: 18, height: 18)
			
			Circle()
				.trim(from: 0.0, to: min(progress, 1.0))
				.stroke(theme.tintColor, style: StrokeStyle(lineWidth: 8.0, lineCap: .round, lineJoin: .round))
				.rotationEffect(Angle(degrees: -90))
				.animation(.linear(duration: 0.2), value: progress)
				.frame(width: 18, height: 18)
		}
		.onAppear {
			if progress >= 1.0 {
				withAnimation(Animation.linear(duration: 0.5).repeatForever(autoreverses: false)) {
					self.progress = 0.0
				}
			}
		}
	}
}
