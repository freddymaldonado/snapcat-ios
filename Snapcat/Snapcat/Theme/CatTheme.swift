//
//  CatTheme.swift
//  Snapcat
//
//  Created by Freddy Maldonado Pereyra on 2/7/24.
//

import SwiftUI

struct CatTheme: Equatable {
	let tintColor: Color
	let backgroundColor: Color
	let navigationFont: UIFont
	let navigationTitleFont: UIFont
	let navigationBackButtonFont: UIFont
	let primaryFont: Font
	let secondaryFont: Font
	let attrFont: Font
	let primaryFontColor: Color
	let secondaryFontColor: Color
	let primaryFontColorLight: Color
	let secondaryFontColorLight: Color
	let cornerRadius: CGFloat
	let basePadding: CGFloat
	let baseSpacing: CGFloat
	let tagSpacing: CGFloat
	let tagOpacity: CGFloat
	let tagBackgroundColor: Color
	let tagFont: Font
	let tagFontColor: Color
	let iconSize: CGFloat
	let mediaPlaceholderColor: Color
	let darkBackgroundBlurStyle: UIBlurEffect.Style
	let lightBackgroundBlurStyle: UIBlurEffect.Style
	
	static let lightTheme = CatTheme(
		tintColor: Color(red: 106 / 255, green: 13 / 255, blue: 173 / 255),
		backgroundColor: .white, 
		navigationFont: CatFont.meows.font(size: 45, weight: .black),
		navigationTitleFont: CatFont.meows.font(size: 30, weight: .black),
		navigationBackButtonFont: CatFont.meows.font(size: 20, weight: .black),
		primaryFont: CatFont.meows.font(size: 18, weight: .black),
		secondaryFont: CatFont.ralewayLight.font(size: 16, weight: .semibold),
		attrFont: CatFont.ralewaySemiBold.font(size: 16, weight: .semibold),
		primaryFontColor: .white,
		secondaryFontColor: .white,
		primaryFontColorLight: .black,
		secondaryFontColorLight: .black,
		cornerRadius: 16,
		basePadding: 8,
		baseSpacing: 8,
		tagSpacing: 5,
		tagOpacity: 0.2,
		tagBackgroundColor: Color(red: 106 / 255, green: 13 / 255, blue: 173 / 255),
		tagFont: CatFont.ralewaySemiBold.font(size: 16, weight: .semibold),
		tagFontColor: Color(red: 106 / 255, green: 13 / 255, blue: 173 / 255).lighten(by: 0.4),
		iconSize: 20,
		mediaPlaceholderColor: Color(red: 30 / 255, green: 30 / 255, blue: 30 / 255).lighten(by: 0.4),
		darkBackgroundBlurStyle: .prominent,
		lightBackgroundBlurStyle: .systemChromeMaterialDark
	)
	
	static let darkTheme = CatTheme(
		tintColor: Color.green,
		backgroundColor: .black, 
		navigationFont: CatFont.meows.font(size: 45, weight: .black), 
		navigationTitleFont: CatFont.meows.font(size: 30, weight: .black),
		navigationBackButtonFont: CatFont.meows.font(size: 20, weight: .black),
		primaryFont: CatFont.meows.font(size: 16, weight: .black),
		secondaryFont: CatFont.ralewayLight.font(size: 16, weight: .semibold), 
		attrFont: CatFont.ralewaySemiBold.font(size: 16, weight: .semibold),
		primaryFontColor: .white,
		secondaryFontColor: .white,
		primaryFontColorLight: .white,
		secondaryFontColorLight: .white,
		cornerRadius: 16,
		basePadding: 8,
		baseSpacing: 8,
		tagSpacing: 5,
		tagOpacity: 0.2,
		tagBackgroundColor: Color.green,
		tagFont: CatFont.ralewaySemiBold.font(size: 16, weight: .semibold),
		tagFontColor: Color.green.lighten(by: 0.4),
		iconSize: 20,
		mediaPlaceholderColor: Color(red: 30 / 255, green: 30 / 255, blue: 30 / 255),
		darkBackgroundBlurStyle: .prominent,
		lightBackgroundBlurStyle: .systemChromeMaterialDark
	)
}
