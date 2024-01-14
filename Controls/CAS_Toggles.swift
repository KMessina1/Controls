/*--------------------------------------------------------------------------------------------------------------------------
    File: CAS_Toggles.swift
  Author: Kevin Messina
 Created: Feb 17, 2022
Modified: Apr 14, 2022
 
©2022 Creative App Solutions, LLC. - All Rights Reserved.
----------------------------------------------------------------------------------------------------------------------------
NOTES:

2022_04_14  - Added colors to checkbox style.
--------------------------------------------------------------------------------------------------------------------------*/


import Foundation
import SwiftUI

/// Useage:
///     Toggle("Active", isOn: $IsActive)
///         .toggleStyle(CAS_ToggleStyles.checkbox())
///
struct CAS_ToggleStyles {
    struct checkbox: ToggleStyle {
        var size:CGFloat = 22.0
        var onColor:Color = .black
        var offColor:Color = .black
        var textColor:Color = .black

        func makeBody(configuration: Configuration) -> some View {
            return HStack {
                configuration.label
                    .foregroundColor(textColor)

                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                    .resizable()
                    .frame(width: size, height: size)
                    .onTapGesture { configuration.isOn.toggle() }
                    .foregroundColor(configuration.isOn ? onColor : offColor)
            }
        }
    }

    struct colored: ToggleStyle {
        var onColor = Color(UIColor.systemGreen)
        var offColor = Color(UIColor.systemRed)
        var thumbColor = Color.white
        
        func makeBody(configuration: Self.Configuration) -> some View {
            HStack {
                Button(action: { configuration.isOn.toggle() } )
                {
                    RoundedRectangle(cornerRadius: 16, style: .circular)
                        .fill(configuration.isOn ? onColor : offColor)
                        .frame(width: 50, height: 29)
                        .overlay(
                            Circle()
                                .fill(thumbColor)
                                .shadow(radius: 1, x: 0, y: 1)
                                .padding(1.5)
                                .offset(x: configuration.isOn ? 10 : -10))
                        .animation(Animation.easeInOut(duration: 0.1), value: UUID())
                }
            }
            .font(.title)
            .padding(.horizontal)
        }
    }
}
