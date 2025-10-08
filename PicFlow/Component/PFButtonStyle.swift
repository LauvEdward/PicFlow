//
//  ButtonModifier.swift
//  PicFlow
//
//  Created by Lauv Edward on 10/8/25.
//

import SwiftUI

struct PFButtonStyle: ButtonStyle {
    var isEnable: Bool = true
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .frame(maxWidth: .infinity, minHeight: 40)
            .foregroundColor(.white)
            .background(!isEnable ? Color.blue.opacity(0.5) : Color.blue)
            .cornerRadius(5)
    }
}
