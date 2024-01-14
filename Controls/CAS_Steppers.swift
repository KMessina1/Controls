//
//--------------------------------------------------------------------------------------------------------------------------
//     File: CAS_Steppers.swift
//   Author: Kevin Messina
//  Created: Jun 30, 2021
// Modified: Sep 01, 2021
// 
// ©2021-2022 Creative App Solutions, LLC. - All Rights Reserved.
//--------------------------------------------------------------------------------------------------------------------------
// NOTES:
//
// 09/21/2021 - Added Monetary Stepper
//--------------------------------------------------------------------------------------------------------------------------
//

import Foundation
import SwiftUI

// MARK: - *** STEPPER ***
struct DigitStruct:Identifiable {
    let id : UUID = UUID()
    let position : Int
    var value : String
}

struct StepperMoneyBoxes: View {
    @Binding var bindingText : String
    var textColor : Color = .black
    var buttonColor : Color = ThemeColors.accentColor
    
    @State private var numDigits : Int = 0
    @State private var digits : [DigitStruct] = []
    @State private var fractions : [DigitStruct] = []

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text("$")
                    .font(.title)
                    .foregroundColor(.black)
                    .frame(width:10)
                    .padding(.horizontal,-5)
                    .padding(.trailing,-5)

                ForEach(digits, id: \.position) { digit in
                    var updatedDigit : DigitStruct = digit
                    var numeral : Int = Int(digit.value)!
                    
                    VStack(alignment:.center) {
                        Button("+") {
                            numeral += 1
                            if numeral > 9 {
                                numeral = 9
                            }
                            updatedDigit.value = String(numeral)
                            digits[updatedDigit.position] = updatedDigit
                            bindingText = buildBindingText()
                        }
                        .foregroundColor(buttonColor)
                        .font(.title)
                        .frame(width:25,height:25)
                        .padding(.bottom,2)
                        .background(buttonColor.opacity(0.33))
                        
                        Text("\( numeral )")
                            .font(.title)
                            .foregroundColor(textColor)
                            .padding(.top,-7)
                        
                        Button("-") {
                            numeral -= 1
                            if numeral < 0 {
                                numeral = 0
                            }
                            updatedDigit.value = String(numeral)
                            digits[updatedDigit.position] = updatedDigit
                            bindingText = buildBindingText()
                        }
                        .foregroundColor(buttonColor)
                        .font(.title)
                        .frame(width:25,height:25)
                        .padding(.bottom,2)
                        .background(buttonColor.opacity(0.33))
                    }
                    .cornerRadius(10)
                    .frame(width:25,height:70)
                    .padding(.vertical,10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(buttonColor))
                }

                Text(".")
                    .font(.title)
                    .foregroundColor(.black)
                    .frame(width:10)
                    .padding(.horizontal,-5)
                    .padding(.trailing,-5)

                ForEach(fractions, id: \.position) { digit in
                    var updatedDigit : DigitStruct = digit
                    var numeral : Int = Int(digit.value)!
                    
                    VStack(alignment:.center) {
                        Button("+") {
                            numeral += 1
                            if numeral > 9 {
                                numeral = 9
                            }
                            updatedDigit.value = String(numeral)
                            digits[updatedDigit.position] = updatedDigit
                            bindingText = buildBindingText()
                        }
                        .foregroundColor(buttonColor)
                        .font(.title)
                        .frame(width:25,height:25)
                        .padding(.bottom,2)
                        .background(buttonColor.opacity(0.33))
                        
                        Text("\( numeral )")
                            .font(.title)
                            .foregroundColor(textColor)
                            .padding(.top,-7)
                        
                        Button("-") {
                            numeral -= 1
                            if numeral < 0 {
                                numeral = 0
                            }
                            updatedDigit.value = String(numeral)
                            digits[updatedDigit.position] = updatedDigit
                            bindingText = buildBindingText()
                        }
                        .foregroundColor(buttonColor)
                        .font(.title)
                        .frame(width:25,height:25)
                        .padding(.bottom,2)
                        .background(buttonColor.opacity(0.33))
                    }
                    .cornerRadius(10)
                    .frame(width:25,height:70)
                    .padding(.vertical,10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(buttonColor))
                }
            }
        }
        .onAppear(perform: {
            loadData()
        })
        .onChange(of: bindingText, perform: { value in
            loadData()
        })
    }
    
    func loadData() {
        digits = []
        fractions = []
        numDigits = bindingText.count
        for digit in 0..<numDigits {
            let value = String(bindingText[digit..<(digit + 1)])
            
            digits.append(DigitStruct.init(position: digit, value: value))
        }

        for fraction in 0..<2 {
            let value = String(bindingText[fraction..<(fraction + 1)])
            
            fractions.append(DigitStruct.init(position: fraction, value: value))
        }

        simPrint(type: .info, msg: "bindingText: \(bindingText), numDigits: \(numDigits), digits: \(digits)", log: logFileFunctionLine())
    }
    
    func buildBindingText() -> String {
        var combinedString:String = ""
        
        for digit in 0..<numDigits {
            combinedString += String(digits[digit].value)
        }
        
        simPrint(type: .info, msg: "buildBindingText: \( combinedString )", log: logFileFunctionLine() )
        
        return combinedString
    }
}

struct StepperBoxes: View {
    @Binding var bindingText : String
    var textColor : Color = .black
    var buttonColor : Color =  ThemeColors.accentColor

    @State private var numDigits : Int = 0
    @State private var digits : [DigitStruct] = []

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                ForEach(digits, id: \.position) { digit in
                    var updatedDigit : DigitStruct = digit
                    var numeral : Int = Int(digit.value)!
                    
                    VStack(alignment:.center) {
                        Button("+") {
                            numeral += 1
                            if numeral > 9 {
                                numeral = 9
                            }
                            updatedDigit.value = String(numeral)
                            digits[updatedDigit.position] = updatedDigit
                            bindingText = buildBindingText()
                        }
                        .foregroundColor(buttonColor)
                        .font(.title)
                        .frame(width:40,height:25)
                        .padding(.bottom,2)
                        .background(buttonColor.opacity(0.33))
                        
                        Text("\( numeral )")
                            .font(.title)
                            .foregroundColor(textColor)
                            .padding(.top,-7)
                        
                        Button("-") {
                            numeral -= 1
                            if numeral < 0 {
                                numeral = 0
                            }
                            updatedDigit.value = String(numeral)
                            digits[updatedDigit.position] = updatedDigit
                            bindingText = buildBindingText()
                        }
                        .foregroundColor(buttonColor)
                        .font(.title)
                        .frame(width:40,height:25)
                        .padding(.bottom,2)
                        .background(buttonColor.opacity(0.33))
                    }
                    .cornerRadius(10)
                    .frame(width:40,height:70)
                    .padding(.vertical,10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(buttonColor))
                }
            }
        }
        .onAppear(perform: {
            loadData()
        })
        .onChange(of: bindingText, perform: { value in
            loadData()
        })
    }
    
    func loadData() {
        digits = []
        numDigits = bindingText.count
        for digit in 0..<numDigits {
            let value = String(bindingText[digit..<(digit + 1)])
            
            digits.append(DigitStruct.init(position: digit, value: value))
        }
        
        simPrint(type: .info, msg: "bindingText: \(bindingText), numDigits: \(numDigits), digits: \(digits)", log: logFileFunctionLine())
    }
    
    func buildBindingText() -> String {
        var combinedString:String = ""

        for digit in 0..<numDigits {
            combinedString += String(digits[digit].value)
        }

        simPrint(type: .info, msg: "buildBindingText: \( combinedString )", log: logFileFunctionLine() )
        
        return combinedString
    }
}

// MARK: -
struct autoRatesStepperBox: View {
    @Binding var bindingText : String
    var textColor : Color = .black
    var buttonColor : Color =  ThemeColors.accentColor
    var prefixText : String = "$"
    
    @State var digit_1 : String = "0"
    @State var fraction_1 : String = "0"
    @State var fraction_2 : String = "0"
    @State var fraction_3 : String = "0"

    var body: some View {
        simPrint(type: .info, msg: bindingText, log: logFileFunctionLine())
        
        return VStack(alignment: .leading) {
            HStack(alignment: .center) {
                if !prefixText.isEmpty {
                    Text(prefixText)
                        .font(.title)
                        .foregroundColor(textColor)
                }
                
                stepperBlock(bindingVal: $digit_1)
                    .onChange(of: digit_1, perform: { value in
                        bindingText = buildBindingText()
                    })
                
                Text(".")
                    .font(.largeTitle)
                    .foregroundColor(textColor)
                
                stepperBlock(bindingVal: $fraction_1)
                    .onChange(of: fraction_1, perform: { value in
                        bindingText = buildBindingText()
                    })
                stepperBlock(bindingVal: $fraction_2)
                    .onChange(of: fraction_2, perform: { value in
                        bindingText = buildBindingText()
                    })
                stepperBlock(bindingVal: $fraction_3)
                    .onChange(of: fraction_3, perform: { value in
                        bindingText = buildBindingText()
                    })
            }
            .padding(.bottom,5)
            .onAppear(perform: {
                let tempVal = bindingText
                
                if tempVal.count == 5 {
                    digit_1 = tempVal[0..<1]
                    fraction_1 = tempVal[2..<3]
                    fraction_2 = tempVal[3..<4]
                    fraction_3 = tempVal[4..<5]
                }
            })
        }
    }
    
    func buildBindingText() -> String {
        return digit_1 + "." + fraction_1 + fraction_2 + fraction_3
    }
}

struct stepperBlock: View {
    @Binding var bindingVal : String
    var textColor : Color = .black
    var buttonColor : Color =  ThemeColors.accentColor
    
    @State var numeral : Int = 0
    
    var body: some View {
        VStack(alignment:.center) {
            Button("+") {
                numeral += 1
                if numeral > 9 {
                    numeral = 9
                }
            }
            .font(.title)
            .frame(width:40,height:26)
            .padding(.bottom,2)
            .background(buttonColor.opacity(0.33))
            
            Text("\( numeral )")
                .font(.title)
                .foregroundColor(textColor)
                .frame(width:40,height:20)

            Button("-") {
                numeral -= 1
                if numeral < 0 {
                    numeral = 0
                }
            }
            .font(.title)
            .frame(width:40,height:26)
            .background(buttonColor.opacity(0.33))
            .padding(.bottom,2)
        }
        .cornerRadius(10)
        .frame(width:40,height:75)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(buttonColor)
                .frame(width:40,height:90)
        )
        .onAppear(perform: {
            simPrint(type: .info, msg: "* numeral: \( numeral )", log: logFileFunctionLine() )
            numeral = Int(bindingVal)!
            simPrint(type: .info, msg: "* bindingVal: \( bindingVal ) / numeral: \( numeral )", log: logFileFunctionLine() )
        })
        .onChange(of: numeral, perform: { value in
            bindingVal = "\( numeral )"
        })
    }
}

struct AdvancedSegmentedPicker<T: CustomStringConvertible & Hashable>: View {
    var items: [T]
    @Binding var selectedItem: T
    
    var backgroundColor: UIColor? = nil
    var selectedSegmentTintColor: UIColor? = nil
    var selectedSegmentForegroundColor: UIColor? = nil
    var normalSegmentForegroundColor: UIColor? = nil
    
    @State private var renderView: Bool = Bool()
    
    var body: some View {
        
        return Group {
            if renderView {
                SegmentedPickerView(
                    items: items,
                    selectedItem: $selectedItem,
                    backgroundColor: backgroundColor,
                    selectedSegmentTintColor: selectedSegmentTintColor,
                    selectedSegmentForegroundColor: selectedSegmentForegroundColor,
                    normalSegmentForegroundColor: normalSegmentForegroundColor
                )
            } else {
                SegmentedPickerView(
                    items: items,
                    selectedItem: $selectedItem,
                    backgroundColor: backgroundColor,
                    selectedSegmentTintColor: selectedSegmentTintColor,
                    selectedSegmentForegroundColor: selectedSegmentForegroundColor,
                    normalSegmentForegroundColor: normalSegmentForegroundColor
                )
            }
        }
        .onChange(of: backgroundColor) { _ in renderView.toggle() }
        .onChange(of: selectedSegmentTintColor) { _ in renderView.toggle() }
        .onChange(of: selectedSegmentForegroundColor) { _ in renderView.toggle() }
        .onChange(of: normalSegmentForegroundColor) { _ in renderView.toggle() }
    }
    
    private struct SegmentedPickerView<T: CustomStringConvertible & Hashable>: View {
        var items: [T]
        @Binding var selectedItem: T
        
        init(items: [T], selectedItem: Binding<T>, backgroundColor: UIColor? = nil,
             selectedSegmentTintColor: UIColor? = nil, selectedSegmentForegroundColor: UIColor? = nil, normalSegmentForegroundColor: UIColor? = nil) {
            
            self.items = items
            self._selectedItem = selectedItem
            
            UISegmentedControl.appearance().backgroundColor = backgroundColor
            UISegmentedControl.appearance().selectedSegmentTintColor = selectedSegmentTintColor
            
            if let unwrappedSelectedSegmentForegroundColor: UIColor = selectedSegmentForegroundColor {
                UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: unwrappedSelectedSegmentForegroundColor], for: .selected)
            }
            else {
                UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.label], for: .selected)
            }
            
            if let unwrappedNormalSegmentForegroundColor: UIColor = normalSegmentForegroundColor {
                UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: unwrappedNormalSegmentForegroundColor], for: .normal)
            }
            else {
                UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.label], for: .normal)
            }
        }
        
        var body: some View {
            Picker("", selection: $selectedItem) {
                
                ForEach(items, id: \.self) { item in
                    
                    Text(String(describing: item))
                    
                }
                
            }
            .pickerStyle(SegmentedPickerStyle())
            
        }
    }

    enum ColorEnum: String, CaseIterable, CustomStringConvertible { case red, yellow, green, blue
        var ColorValue: UIColor {
            get {
                switch self {
                    case .red: return UIColor.red
                    case .yellow: return UIColor.yellow
                    case .green: return UIColor.green
                    case .blue: return UIColor.blue
                }
            }
        }
        
        var description: String {
            get { return self.rawValue }
        }
    }
}


