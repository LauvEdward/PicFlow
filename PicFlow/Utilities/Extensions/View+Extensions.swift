//
//  View+Extensions.swift
//  PicFlow
//
//  Created by Lauv Edward on 10/22/25.
//

import Foundation
import SwiftUI
extension View {
    func pfCard() -> some View { modifier(PFCard()) }

    func placeholder(_ show: Bool, alignment: Alignment = .topLeading, @ViewBuilder _ view: () -> some View) -> some View {
        ZStack(alignment: alignment) {
            self
            if show { view().allowsHitTesting(false) }
        }
    }

    func primaryCapsule() -> some View {
        self
            .font(.headline)
            .padding(.horizontal, 16).padding(.vertical, 10)
            .background(
                LinearGradient(colors: [.brandTop, .brandBottom], startPoint: .topLeading, endPoint: .bottomTrailing),
                in: Capsule()
            )
            .foregroundStyle(.white)
            .shadow(color: .shadow, radius: 10, x: 0, y: 6)
    }

    func frostedCircleIcon() -> some View {
        self
            .font(.system(size: 16, weight: .semibold))
            .padding(10)
            .background(.ultraThinMaterial, in: Circle())
            .shadow(color: .shadow, radius: 8, x: 0, y: 4)
    }
}


// MARK: - Style Kit (drop-in, không đổi logic)
enum PFTheme {
    static let radius: CGFloat = 18
    static let cardPadding: CGFloat = 14
}

extension Color {
    static let appBG = Color(UIColor.systemGroupedBackground)
    static let cardStroke = Color.white.opacity(0.25)
    static let shadow = Color.black.opacity(0.15)
    static let brandTop = Color.blue
    static let brandBottom = Color.cyan
}

struct PFCard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(PFTheme.cardPadding)
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: PFTheme.radius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: PFTheme.radius, style: .continuous)
                    .strokeBorder(Color.cardStroke, lineWidth: 1)
            )
            .shadow(color: .shadow, radius: 12, x: 0, y: 6)
    }
}

