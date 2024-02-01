//
//  ContentView.swift
//  3DModelPicker
//
//  Created by Tobin Pomeroy on 1/25/24.
//

import SwiftUI
import RealityKit
import ARKit
import Combine

struct ContentView : View {
    @State var showPicker = false
    @State var modelToLoad: ModelEntity?
    var modelItems = [ModelItem]()

    var body: some View {
        ZStack {
            ARViewContainer(modelToLoad: $modelToLoad)
                .edgesIgnoringSafeArea(.all)
                .gesture(
                    TapGesture()
                        .onEnded { self.showPicker.toggle() }
                )
            ModelPickerView(showPicker: $showPicker, modelToLoad: $modelToLoad).opacity(showPicker ? 0.8 : 0)
        }
    }
}
