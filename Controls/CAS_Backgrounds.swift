//
//--------------------------------------------------------------------------------------------------------------------------
//     File: CAS_Backgrounds.swift
//   Author: Kevin Messina
//  Created: 7/1/21
// Modified:
// 
// ©2021-2022 Creative App Solutions, LLC. - All Rights Reserved.
//--------------------------------------------------------------------------------------------------------------------------
// NOTES:
//--------------------------------------------------------------------------------------------------------------------------
//

import Foundation
import SwiftUI


// MARK: - *** BACKGROUND BOX ***
struct backgroundBox: View {
    var backgroundOpacity:Double = 0.10
    var strokeColor:Color = .black

    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(strokeColor.opacity(0.20), lineWidth: 3)
            .background(Color.white.opacity(backgroundOpacity))
            .cornerRadius(10)
    }
}

// MARK: - *** CIRCLE ICON ***
struct circleIcon: View {
    var size:CGFloat = 30
    var color:Color = .white
    var iconColor:Color = .orange
    var systemIconName:String = "arrow.down"
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer().frame(height:5)
            
            ZStack {
                Circle()
                    .fill(color)
                    .frame(width: size - 10, height: size - 10)
                
                Image(systemName: systemIconName)
                    .resizable()
                    .foregroundColor(iconColor)
                    .frame(width: size / 2 , height: size / 2)
            }
            
            Spacer().frame(height:5)
        }
        .padding(.bottom,8)
    }
}

// MARK: - *** COLOR BACKGROUNDS - Full Screen ***
enum GradientStyle:Int { case linear,linearAngle,radial,angular }

struct gradientBackground_FullScreen: View {
    var style:GradientStyle
    var gradients:[Color]
    
    var body: some View {
        VStack {
            switch style {
                case .linear:
                    LinearGradient(
                        gradient: Gradient(colors: gradients),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                case .linearAngle:
                    LinearGradient(
                        gradient: Gradient(colors: gradients),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                case .radial:
                    RadialGradient(
                        gradient: Gradient(colors: gradients.reversed()),
                        center: .center,
                        startRadius: 100,
                        endRadius: 470
                    )
                case .angular:
                    AngularGradient(
                        gradient: Gradient(colors: gradients),
                        center: .center
                    )
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct setBackgroundColor_FullScreen:View {
    var color:Color = .red
    
    var body: some View {
        Rectangle()
            .foregroundColor(.clear)
            .background(color)
            .edgesIgnoringSafeArea(.all)
    }
}

struct setBackgroundOverlay_FullScreen:View {
    var color:Color = .black
    
    var body: some View {
        RoundedRectangle(cornerRadius:0.01)
            .fill(color.opacity(0.75))
            .edgesIgnoringSafeArea(.all)
    }
}

