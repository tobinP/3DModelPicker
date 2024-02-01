//
//  ModelPickerView.swift
//  3DModelPicker
//
//  Created by Tobin Pomeroy on 1/30/24.
//

import SwiftUI
import RealityKit

struct ModelPickerView : View {
    @Binding var showPicker: Bool
    @Binding var modelToLoad: ModelEntity?
    @State private var modelItems = [ModelItem]()

    var body: some View {
        TabView {
            ForEach(modelItems) { item in
                VStack {
                    Text(item.name).frame(alignment: .top)
                    Button {
                        showPicker = false
                        if let model = item.modelEntity {
                            modelToLoad = model
                        }
                    } label: {
                        item.image
                            .resizable()
                            .frame(width: 250, height: 250, alignment: .bottom)
                    }
                }
            }
        }
        .task {
            let modelNames = FileService.getAllUsdzFileNames()
            for name in modelNames {
                modelItems.append(ModelItem(name: name))
            }
        }
        .tabViewStyle(.page)
    }
}
