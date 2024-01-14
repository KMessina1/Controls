
/*--------------------------------------------------------------------------------------------------------------------------
    File: CAS_Pickers.swift
  Author: Kevin Messina
 Created: Feb 9, 2022
Modified: Apr 15, 2022

©2022 Creative App Solutions, LLC. - All Rights Reserved.
----------------------------------------------------------------------------------------------------------------------------
NOTES:
--------------------------------------------------------------------------------------------------------------------------*/


import SwiftUI

// MARK: MULTIPICKER MODIFIER
struct multipickerModifier: ViewModifier {
    var width:CGFloat
    var height:CGFloat
    
    func body(content: Content) -> some View {
        content
            .pickerStyle(WheelPickerStyle())
            .labelsHidden()
            .frame(width:width,height:height)
            .background(Color.white)
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(ThemeColors.green, lineWidth: 2))
            .clipped()
            .contentShape(Rectangle())
//            .background(Color.red)
    }
}

// MARK: PICKER STATES
struct CAS_Picker_States: View {
    // MARK: PROPERTIES
    @Binding var name:String
    var isUSA:Bool
    var width:CGFloat
    var height:CGFloat = 115.0

    @State private var selections: [String] = [""]
    
    private let states:[String] = Jurisdictions.US().arrNames(jurisdictions: Jurisdictions.US.StatesAndDCAndPR)
    private let provinces:[String] = Jurisdictions.Canada().arrNames(jurisdictions: Jurisdictions.Canada.all)

    // MARK: BODY
    var body: some View {
        let data = isUSA ?states :provinces
        
        VStack {
            HStack{
                Spacer()
                
                MultiWheelPicker(selections: self.$selections, data: [data])
                    .modifier(multipickerModifier(width: width, height: height))
                    .clipped()
                    .contentShape(Rectangle())
                    .onChange(of: selections) { _ in name = selections[0] }

                Spacer()
            }
        }
        .onAppear {
            let data = isUSA ?states :provinces
            selections[0] = data[data.firstIndex(of: name) ?? 0]
        }
    }
}

// MARK: PICKER STATES VIEW
struct CAS_Picker_States_View : View {
    // MARK: PROPERTIES
    @Binding var binding_show:Bool
    @Binding var binding_name:String
    var isUSA:Bool
    var width:CGFloat
    
    // MARK: BODY
    var body: some View {
        withAnimation {
            ZStack {
                VStack(alignment: .leading) {
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        titleView(showBinding: $binding_show, title: "Choose \(isUSA ?"State" :"Province")", iconName: AppImages.settingImgs.globe)
                        
                        CAS_Picker_States(name: $binding_name, isUSA: isUSA, width: width)
                            .padding(.vertical,10)
                    }//End VStack
                    .modifier(viewMaster(maxHeight: 220))
                }
            }// End ZStack
            .zIndex(5)
        }//End Animation
    }
}


// MARK: PICKER ZIP CODE
struct CAS_Picker_ZipCode: View {
    // MARK: PROPERTIES
    @Binding var code:String
    var isUSA:Bool
    var width:CGFloat = 250.0
    var height:CGFloat = 115.0
    
    @State private var selections:[String] = ["","","","","","",""]
    
    private let numbers:[String] = ["0","1","2","3","4","5","6","7","8","9"]
    private let alphas:[String] = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    @ViewBuilder func returnPickerWheelView(selection:Binding<String>,data:[String]) -> some View {
        Picker("", selection: selection) {
            ForEach(0..<data.count, id: \.self) { index in
                Text("\(data[index])").tag("\(data[index])")
            }
        }
        .pickerStyle(.wheel)
        .fixedSize(horizontal: true, vertical: true)
        .labelsHidden()
        .frame(width: 25,height: height)
        .compositingGroup()
        .clipped()
    }
    
    // MARK: BODY
    var body: some View {
        HStack(alignment: .center) {
            Spacer()

            Group {
                returnPickerWheelView(selection: $selections[0], data: isUSA ?numbers : alphas)
                Spacer()
                returnPickerWheelView(selection: $selections[1], data: numbers)
                Spacer()
                returnPickerWheelView(selection: $selections[2], data: isUSA ?numbers : alphas)
                Spacer()
                returnPickerWheelView(selection: $selections[3], data: numbers)
                Spacer()
                returnPickerWheelView(selection: $selections[4], data: isUSA ?numbers : alphas)
                if !isUSA {
                    Spacer()
                    returnPickerWheelView(selection: $selections[5], data: numbers)
                }
            }
            
            Spacer()
        }
        .frame(height: height)
        .mask(Rectangle())
    }
}

// MARK: PICKER ZIP CODE VIEW
struct CAS_Picker_ZipCode_View : View {
    // MARK: PROPERTIES
    @Binding var binding_show:Bool
    @Binding var binding_code:String
    var isUSA:Bool
    var width:CGFloat
    
    // MARK: BODY
    var body: some View {
        withAnimation {
            ZStack {
                blurredBackground(style: .light)
                
                VStack(alignment: .leading) {
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        titleView(showBinding: $binding_show, title: "Choose \(isUSA ?"Zip" :"Postal") Code", iconName: AppImages.settingImgs.mailStack)

                        CAS_Picker_ZipCode(code: $binding_code, isUSA: isUSA, width: width)
                            .padding(.vertical,10)
                    }//End VStack
                    .modifier(viewMaster(maxHeight: 220))
                }
            }// End ZStack
            .zIndex(5)
        }//End Animation
    }
}


// MARK: MULTIWHEEL PICKER
struct MultiWheelPicker: UIViewRepresentable {
    var selections: Binding<[String]>
    let data: [[String]]
    
    func makeCoordinator() -> MultiWheelPicker.Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<MultiWheelPicker>) -> UIPickerView {
        let picker = UIPickerView()
            picker.dataSource = context.coordinator
            picker.delegate = context.coordinator
        
        return picker
    }
    
    func updateUIView(_ view: UIPickerView, context: UIViewRepresentableContext<MultiWheelPicker>) {
        for comp in selections.indices {
            if let row = data[comp].firstIndex(of: selections.wrappedValue[comp]) {
                view.selectRow(row, inComponent: comp, animated: false)
            }
        }
    }
    
    class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
        var parent: MultiWheelPicker
        
        init(_ pickerView: MultiWheelPicker) {
            parent = pickerView
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return parent.data.count
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return parent.data[component].count
        }
        
        func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
            return 48
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return parent.data[component][row]
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            parent.selections.wrappedValue[component] = String(parent.data[component][row])
        }
    }
}


// MARK: PREVIEW
struct CAS_Picker_Previews: PreviewProvider {
    static var previews: some View {
//        CAS_Picker_States(name: .constant(""), isUSA: true, width: 400)
//        CAS_Picker_ZipCode_View(binding_show: .constant(true), binding_code: .constant(""), isUSA: true, width: 200)
        CAS_Picker_ZipCode(code: .constant(""), isUSA: true, width: 200, height: 115)
    }
}


