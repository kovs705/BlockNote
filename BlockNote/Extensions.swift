//
//  Extensions.swift
//  BlockNote
//
//  Created by Kovs on 21.10.2021.
//

import Foundation
import SwiftUI

// MARK: - Extensions

extension View {
    public func gradientForegroundColor(colors: [Color]) -> some View {
        self.overlay(LinearGradient(gradient: .init(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing))
            .mask(self)
    }
}

struct BluredButtonInTabBar: ButtonStyle {
    @Environment(\.colorScheme) public var detectTheme
    
    func makeBody(configuration: Self.Configuration) -> some View {
        if detectTheme == .dark {
        configuration.label
            .padding(20)
            .cornerRadius(20)
            .background(BlurView(style: .regular))
            // .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .frame(width: 70, height: 69)
        } else {
            configuration.label
                .padding(20)
                .cornerRadius(20)
                .background(Color.white)
                .frame(width: 70, height: 69)
                .shadow(color: .black.opacity(0.3), radius: 10, y: -5)
        }
    }
}

extension Color {
    static let darkBack = Color("DarkBackground")
    static let lightPart = Color("LightPart")
    
    // pastel colors:
    static let rosePink = Color("RosePink") // rose
    static let greenAvocado = Color("GreenAvocado") // green
    static let blueBerry = Color("BlueBerry") // blue
    static let yellowLemon = Color("YellowLemon") // yellow
    static let redStrawBerry = Color("RedStrawBerry") // red
    static let purpleBlackBerry = Color("PurpleBlackBerry") // purple
    static let greyCloud = Color("GreyCloud") // grey
    static let brownSugar = Color("BrownSugar") // brown
    static let textForeground = Color("TextForeground") // text based on theme (dark and light)
    
    public static var darkBlue: Color {
        return Color(red: 28 / 255, green: 46 / 255, blue: 74 / 255)
    }
    public static var offWhite: Color {
        return Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
    }
    public static var veryDarkBlue: Color {
        return Color(red: 10 / 255, green: 20 / 255, blue: 50 / 255)
    }
    public static var darkGold: Color {
        return Color(red: 133 / 255, green: 94 / 255, blue: 60 / 255)
    }
}

/*
 LinearGradient(gradient: Gradient(colors: [.pink, .blue]),
                startPoint: .top,
                endPoint: .bottom)
     .mask(Text("your text"))
 */

/*                                    if onDeleting {
                                        Button(action: {
                                            // deleting action here:
                                            // deleteGroup(at: )
                                        }) {
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 20)
                                                    .fill(Color.red)
                                                    .frame(width: 30, height: 30)
                                                    .zIndex(-4)
                                                Image(systemName: "minus")
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 18))
                                                    .zIndex(-4)
                                            }
                                        }
                                        .environment(\.editMode, .constant(self.isEditing ? EditMode.active : EditMode.inactive)).animation(.spring())
                                        .zIndex(-4)
                                    }
 */

