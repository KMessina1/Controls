/*--------------------------------------------------------------------------------------------------------------------------
    File: CAS_Dividers.swift
  Author: Kevin Messina
 Created: Jul 1, 2021
Modified: May 17, 2022
 
©2021-2022 Creative App Solutions, LLC. - All Rights Reserved.
----------------------------------------------------------------------------------------------------------------------------
NOTES:
 
2022_05_17  - Modified LabeledDivider() to a func and added several formatting paramters to make more customizable.
--------------------------------------------------------------------------------------------------------------------------*/


import Foundation
import SwiftUI

// MARK: - *** DIVIDERS ***
struct sectionDividerAndTitle: View {
    var title:String = ""
    var titleColor:Color = .white
    var topPadding:CGFloat = 30.0
    var bottomPadding:CGFloat = 3.0
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer().frame(height:topPadding)
            LabeledDivider(label: title, horizontalPadding: 5.0, lineColor: titleColor, textColor: titleColor)
            Spacer().frame(height:bottomPadding)
        }
    }
}

func LabeledDivider(
    label:String,
    horizontalPadding:CGFloat = 20.0,
    verticalPadding:CGFloat = 5.0,
    lineColor:Color = .black,
    textColor:Color = .white,
    background:Color = .red,
    stroke:Bool = true,
    font:Font = .footnote
) -> some View {
    func line() -> some View {
        VStack(alignment: .leading) { // Forces horizontal Divider
            Divider()
                .background(lineColor)
        }
    }

    return ZStack {
        line()
        
        Text(label)
            .font(font)
            .foregroundColor(textColor)
            .lineLimit(1)
            .padding(.horizontal,10)
            .padding(.vertical,verticalPadding)
            .background(
                ZStack {
                    Color.white
                    background
                }
            )
            .cornerRadius(10.0)
            .clipped()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(stroke ?lineColor :.clear, lineWidth: 1.5)
            )
    }
    .padding(horizontalPadding)
}

struct lineDivider: View {
    var lineColor: Color = Color.white
    var verticalPadding: CGFloat = 5.0
    
    var body: some View {
        Divider()
            .background(lineColor)
            .padding(.vertical,verticalPadding)
            .padding(.horizontal)
    }
}


