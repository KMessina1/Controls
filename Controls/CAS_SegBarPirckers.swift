//
//--------------------------------------------------------------------------------------------------------------------------
//     File: CAS_SegBarPirckers.swift
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

// MARK: - *** SEG BAR PICKERS ***
struct segBarPicker: View {
    @Binding var selected:Int // Binds to a passed $bound variable in calling view.
    var data:[String] = []
    var color:Color = .red
    var rounded: Bool = true
    var maxWidth: CGFloat = UIScreen.main.bounds.width
    
    var body: some View {
        Picker(selection: $selected, label: EmptyView()) {
            ForEach(0..<data.count, id: \.self) {
                Text(self.data[$0]).tag($0)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .background(color)
        .frame(maxWidth: maxWidth)
        .cornerRadius(rounded ?8 :0)
    }
}
