//
//--------------------------------------------------------------------------------------------------------------------------
//     File: CAS_Labels.swift
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

// MARK: - *** TITLED LABEL ***
struct labelPickerField: View {
    var title:String
    var value1:String
    var suffix1:String? = nil
    var value2:String? = nil
    var suffix2:String? = nil
    var titleColor: Color = .white
    var width: CGFloat = 200.0
    
    var body: some View {
        VStack(alignment: .leading) {
            if !title.isEmpty {
                Spacer().frame(height:3)
                
                Text(title).font(.caption).foregroundColor(titleColor)
                
                Spacer().frame(height:10)
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(appInfo.Theme.title.opacity(0.20), lineWidth: 3)
                    .background(Color.white.opacity(0.10))
                    .cornerRadius(10)
                    .frame(height:44)
                    .offset(y:-5)
                
                HStack(spacing:0) {
                    Text(value1)
                        .foregroundColor(titleColor)
                        .font(.title)
                        .offset(y:-5)
                        .frame(alignment: .leading)
                    
                    if (suffix1 != nil) {
                        Text(suffix1!)
                            .foregroundColor(titleColor)
                            .font(.headline)
                            .offset(y:-12)
                            .frame(alignment: .leading)
                    }
                }
            }
        }
        .frame(width: width)
    }
}
