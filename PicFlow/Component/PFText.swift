//
//  PFText.swift
//  PicFlow
//
//  Created by Lauv Edward on 10/8/25.
//

import SwiftUI

struct PFSubTextBlue: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .foregroundColor(.blue)
    }
}


extension View {
    func subTextBlue() -> some View {
        self.modifier(PFSubTextBlue())
    }
}
