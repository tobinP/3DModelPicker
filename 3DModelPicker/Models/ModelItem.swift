//
//  ModelItem.swift
//  3DModelPicker
//
//  Created by Tobin Pomeroy on 1/25/24.
//

import Foundation
import RealityKit
import Combine
import SwiftUI

class ModelItem: Identifiable {
    var id = UUID()
    var name: String
    var image: Image
    var modelEntity: ModelEntity?
    var cancellable: AnyCancellable?

    init(name: String) {
        self.name = name
        self.image = Image(name)

        cancellable = ModelEntity.loadModelAsync(named: name)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Unable to load a model: \(error)")
                }
                self.cancellable?.cancel()
            }, receiveValue: { [weak self] modelEntity in
                self?.modelEntity = modelEntity
            })
    }
}
