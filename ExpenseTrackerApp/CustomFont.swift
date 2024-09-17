//
//  CustomFont.swift
//  ExpenseTrackerApp
//
//  Created by Hieu Dang on 7/23/24.
//
import SwiftUI

struct CustomFontModifier: ViewModifier {
    var size: CGFloat
    var weight: Font.Weight

    func body(content: Content) -> some View {
        content
            .font(.custom("AnonymousPro-Regular", size: size).weight(weight))
    }
}

extension View {
    func customFont(size: CGFloat, weight: Font.Weight = .regular) -> some View {
        self.modifier(CustomFontModifier(size: size, weight: weight))
    }
}
