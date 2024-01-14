//
//--------------------------------------------------------------------------------------------------------------------------
//     File: CAS_Images.swift
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


// MARK: - *** IMAGES ***
struct NSFW: ViewModifier {
    func body(content: Content) -> some View {
        ZStack(alignment: .center, content: {
            content
                .layoutPriority(1)
                .blur(radius: 30).clipped()
            VStack {
                Image(systemName: "eye.slash.fill").foregroundColor(.white)
                Text("NSFW").font(.caption).bold().foregroundColor(.white)
            }
        })
    }
}

extension Image {
    func makeNSFW() -> some View {
        self.modifier(NSFW())
    }
    
    func makeAvatar(frameSize:CGFloat) -> some View {
        self
            .resizable()
            .frame(width: frameSize, height: frameSize)
            .cornerRadius(frameSize / 2.0)
            .clipShape(Circle())
            .overlay(
                Circle().stroke(Color.white, lineWidth: 2)
            )
            .padding(2)
            .overlay(
                Circle().strokeBorder(Color.black.opacity(0.1), lineWidth: 1)
            )
            .shadow(radius: 3)
            .padding(4)
            .animation(.spring(),value: UUID())
    }
}

