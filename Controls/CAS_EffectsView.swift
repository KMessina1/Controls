/*--------------------------------------------------------------------------------------------------------------------------
    File: CAS_EffectsView.swift
  Author: Kevin Messina
 Created: 7/1/21
Modified:
 
©2021-2022 Creative App Solutions, LLC. - All Rights Reserved.
----------------------------------------------------------------------------------------------------------------------------
NOTES:
--------------------------------------------------------------------------------------------------------------------------*/


import Foundation
import SwiftUI

/// Ex:     VisualEffectView(effect: UIBlurEffect(style: .dark))
struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView {
        UIVisualEffectView()
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) {
        uiView.effect = effect
    }
}

struct blurredBackground: View {
    let style:UIBlurEffect.Style
    
    var body: some View {
        VisualEffectView(effect: UIBlurEffect(style: style))
            .zIndex(0)
    }
}
