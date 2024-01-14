//
//--------------------------------------------------------------------------------------------------------------------------
//     File: CAS_Progress.swift
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

// MARK: - *** PROGRESS BAR ***
struct ProgressBar : View {
    @Binding var progress: CGFloat
    var width: CGFloat = 200.0
    var color: Color = .red
    var height: CGFloat = 12.0
    
    var body: some View {
        HStack {
            Text("Progress").foregroundColor(.white)
            
            ZStack(alignment: Alignment.leading) {
                Rectangle()
                    .foregroundColor(color)
                    .opacity(0.3)
                    .frame(width: self.width, height: height)
                
                Rectangle()
                    .foregroundColor(color)
                    .frame(width: self.width * (self.progress / 100.0), height: height)
            }
            .cornerRadius(height / 2.0)
            
            Text("\( Int(self.progress) )%").foregroundColor(.white)
        }
        .padding(.horizontal,20)
    }
}

struct ProgressCircle: View {
    @Binding var value:CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .trailing) {
                Text("Progress: \(self.getPercentage(self.value))")
                    .padding()
                ZStack(alignment: .leading) {
                    Rectangle()
                        .opacity(0.1)
                    Rectangle()
                        .frame(minWidth: 0, idealWidth:self.getProgressBarWidth(geometry: geometry),
                               maxWidth: self.getProgressBarWidth(geometry: geometry))
                        .opacity(0.5)
                        .background(Color.green)
                        .animation(.default,value: UUID())
                }
                .frame(height:10)
            }.frame(height:10)
        }
    }
    
    func getProgressBarWidth(geometry:GeometryProxy) -> CGFloat {
        let frame = geometry.frame(in: .global)
        return frame.size.width * self.value
    }
    
    func getPercentage(_ value:CGFloat) -> String {
        let intValue = Int(ceil(self.value * 100))
        return "\(intValue) %"
    }
}
