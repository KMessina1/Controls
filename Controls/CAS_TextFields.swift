//
//--------------------------------------------------------------------------------------------------------------------------
//     File: CAS_TextFields.swift
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


// MARK: - *** TEXT FIELDS ***
func dismissKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),to:nil,from:nil,for:nil)
}

struct txtField: View {
    @Binding var binding: String
    var placeholder: String = ""
    @Binding var editMode: Bool
    var keyboardType: UIKeyboardType = .default
    var capitalization: UITextAutocapitalizationType = .none
    var padding:CGFloat = 8
    
    var body: some View {
        TextField(placeholder,
                  text: $binding,
                  onEditingChanged: { changed in
                    self.editMode = changed
                  }, onCommit: {
                    self.editMode = false
                  }
        )
        .modifier(textFieldModifier(keyboardType: keyboardType,capitalization: capitalization,padding: padding))
    }
}

struct textField_TopTitle: View {
    @Binding var binding : String
    var placeholder : String
    var titleColor : Color
    var keyboardType : UIKeyboardType
    var capitalization : UITextAutocapitalizationType
    var outlineTxtField : Bool
    var title : String = ""
    @State var editMode : Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title.isEmpty ? placeholder : title)
                .font(.caption)
                .foregroundColor(titleColor)
                .padding(.bottom,-5)
            
            txtField(binding: $binding, placeholder: placeholder, editMode: $editMode, keyboardType: keyboardType, capitalization: capitalization,padding:0)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .background(Color.clear)
    }
}

struct textField_generic: View {
    @Binding var binding: String
    var placeholder: String = ""
    @Binding var editMode: Bool
    var showTitle: Bool = true
    var titleColor: Color = .white
    var titleWidth: CGFloat = 90
    var keyboardType: UIKeyboardType = .default
    var capitalization: UITextAutocapitalizationType = .none
    var titleOnTop: Bool = true
    var showBackground: Bool = false
    var outlineTxtField: Bool = false
    
    var body: some View {
        let strokeColor:Color = outlineTxtField ?appInfo.Theme.title.opacity(0.20) :Color.clear
        let backgroundColor:Color = showBackground ?appInfo.Theme.title.opacity(0.10) :Color.clear
        let backgroundPadding:CGFloat = showBackground ?10 :0
        let backgroundPadding2:CGFloat = showBackground ?5 :0
        
        HStack {
            if showTitle {
                if titleOnTop {
                    VStack(alignment: .leading) {
                        Text(placeholder)
                            .font(.caption)
                            .foregroundColor(titleColor)
                        
                        txtField(binding: $binding, placeholder: placeholder, editMode: $editMode, keyboardType: keyboardType, capitalization: capitalization)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(strokeColor, lineWidth: 2)
                                    .background(backgroundColor)
                                    .cornerRadius(10)
                            )
                    }
                    .padding(.top,backgroundPadding2)
                }else{
                    Text("\(placeholder):")
                        .font(.headline)
                        .foregroundColor(titleColor)
                        .frame(width: titleWidth, alignment: .trailing)
                    
                    txtField(binding: $binding, placeholder: placeholder, editMode: $editMode, keyboardType: keyboardType, capitalization: capitalization)
                }
            }else{
                txtField(binding: $binding, placeholder: placeholder, editMode: $editMode, keyboardType: keyboardType, capitalization: capitalization)
            }
            
        }
        .padding([.horizontal,.bottom],backgroundPadding)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(strokeColor, lineWidth: 3)
                .background(backgroundColor)
                .cornerRadius(10)
        )
    }
}

struct textFieldModifier: ViewModifier {
    var keyboardType: UIKeyboardType = .default
    var capitalization: UITextAutocapitalizationType = .none
    var padding: CGFloat = 8
    var textColor:Color = .black
    var cornerRadius:CGFloat = 5
    var backgroundColor:Color = .white
    
    func body(content: Content) -> some View {
        content
            .padding(.all, padding)
            .cornerRadius(cornerRadius)
            .keyboardType(keyboardType)
            .autocapitalization(capitalization)
            .disableAutocorrection(true)
            .foregroundColor(textColor)
            .accentColor(.lead)
            .multilineTextAlignment(.leading)
    }
}

struct textFieldModifier_Outlined: ViewModifier {
    var keyboardType: UIKeyboardType = .default
    var capitalization: UITextAutocapitalizationType = .none
    var rowHeight:CGFloat
    var color:Color = .black
    var borderColor:Color =  ThemeColors.accentColor
    var textContentType: UITextContentType = .name
    var submitLabel:SubmitLabel = .next
    
    func body(content: Content) -> some View {
        content
            .frame(height: rowHeight)
            .padding(.all, 5)
            .keyboardType(keyboardType)
            .autocapitalization(capitalization)
            .disableAutocorrection(true)
            .textContentType(textContentType)
            .submitLabel(submitLabel)
            .foregroundColor(color)
            .accentColor(.lead)
            .multilineTextAlignment(.leading)
            .overlay(Rectangle().stroke(borderColor, lineWidth: 1))
            .padding(.top,-1)
    }
}

struct textFieldModifier_Form: ViewModifier {
    var keyboardType: UIKeyboardType = .default
    var capitalization: UITextAutocapitalizationType = .none
    
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 5)
            .keyboardType(keyboardType)
            .autocapitalization(capitalization)
            .disableAutocorrection(true)
            .foregroundColor(.black)
            .accentColor(.lead)
            .multilineTextAlignment(.leading)
    }
}
