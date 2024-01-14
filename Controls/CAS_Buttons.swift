/*--------------------------------------------------------------------------------------------------------------------------
File: CAS_Buttons.swift
Author: Kevin Messina
Created: 7/1/21
Modified: 6/13/23
 
©2023 Creative App Solutions, LLC. - All Rights Reserved.
----------------------------------------------------------------------------------------------------------------------------
NOTES:
--------------------------------------------------------------------------------------------------------------------------*/


import Foundation
import SwiftUI

// MARK: - *** BUTTONS ***
struct button_IconWithTitle: View {
    var title: String = "Done"
    var systemImgName: String = "xmark"
    var titleColor: Color = .black
    var fillColor: Color = .white
    var height:CGFloat = 44
    var width:CGFloat = 64
    var imgSize:CGFloat = 16
    var titleSize:CGFloat = 16
    var padding:CGFloat = 5
    var vertical:Bool = true
    
    var body: some View {
        let imgView = Image(systemName: systemImgName)
            .resizable()
            .foregroundColor(titleColor)
            .frame(width: imgSize, height: imgSize)
        
        let txtView = Text(title)
            .font(Font.system(size: titleSize))
            .foregroundColor(titleColor).bold()
            .frame(
                width: vertical ?width - 10 :width - imgSize - 10,
                height: imgSize,
                alignment: vertical ?.center :.leading
            )
        
        let shapeView = Capsule()
            .fill(fillColor)
            .frame(width: width, height: height)
            .overlay(
                Capsule()
                    .stroke(titleColor, lineWidth: 2)
            )
        
        return VStack {
            ZStack{
                shapeView
                
                if vertical {
                    VStack(spacing:5) {
                        imgView
                            .padding(.top,5)
                        
                        txtView
                            .padding(.bottom,5)
                    }
                    .frame(width: width, height: height)
                }else{
                    HStack(spacing:10) {
                        imgView
                            .padding(.leading,50)
                        
                        txtView
                            .padding(.trailing,20)
                    }
                    .frame(width: width, height: height)
                }
            }
        }
    }}

struct button_Icon: View {
    var systemImgName: String = "xmark"
    var titleColor: Color = .black
    var fillColor: Color = .white
    var width:CGFloat = 30
    var imgSize:CGFloat = 30
    var padding:CGFloat = 7
    
    var body: some View {
        VStack {
            ZStack{
                Circle()
                    .fill(fillColor)
                    .frame(width: width, height: 44)
                    .overlay(
                        Circle()
                            .stroke(titleColor, lineWidth: 2)
                    )
                
                Image(systemName: systemImgName)
                    .resizable()
                    .foregroundColor(titleColor)
                    .frame(width: imgSize, height: imgSize)
                    .padding(.top,padding)
            }
        }
    }
}

struct ButtonContent: View {
    var title:String = "not set"
    var disabled:Bool = false
    var wide:CGFloat = 100
    var tall:CGFloat = 40
    var disabledColor:Color = .gray
    var enabledColor:Color =  .black
    var titleColor:Color = Color.white
    
    var body: some View {
        Text(title)
            .font(.headline)
            .fontWeight(.bold)
            .foregroundColor(disabled ?.gray :titleColor)
            .frame(width: wide, height: tall)
            .background(disabled ?disabledColor :enabledColor)
            .cornerRadius(15)
            .padding()
    }
}

// MARK: - *** Disclaimer Button ***
/// disclaimerButton returns a SwiftUI compatible red button with white text.
/// - Requires: SwiftUI
/// - Parameters
///   - show:Bool = Binded value to toggle view flag to caller
///   - alert:Alert = Alert view to display
///   - title:String = (optional) Title string
///   - height:CGFloat = (optional) Button Height
///   - width:CGFloat = (optional) Button width
///   - imgSize:CGFloat = (optional) point size of SF image
///   - titleSize:CGFloat = (optional) point size of title font
///   - vertical:Bool = (optional) Display image stacked veritcally or horizontal to title.
struct disclaimerButton: View {
    @Binding var show:Bool
    var alert:Alert
    var title:String = "Disclaimer"
    var height:CGFloat = 44
    var width:CGFloat = 160
    var imgSize:CGFloat = 24
    var titleSize:CGFloat = 20
    var vertical:Bool = false
    
    var body: some View {
        Button(action: {
            self.show.toggle()
        }) {
            button_IconWithTitle(
                title: title,
                systemImgName: "exclamationmark.triangle.fill",
                titleColor: .white,
                fillColor: Color.red.opacity(0.10),
                height: height,
                width: width,
                imgSize: imgSize,
                titleSize: titleSize,
                vertical: vertical
            )
        }
        .padding(.vertical,15)
        .alert(isPresented: self.$show, content: { self.alert })
    }
}

