//
//  ARView.swift
//  3DModelPicker
//
//  Created by Tobin Pomeroy on 1/30/24.
//

import SwiftUI
import RealityKit
import ARKit

struct ARViewContainer: UIViewRepresentable {
    @Binding var modelToLoad: ModelEntity?

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)

        let config = ARWorldTrackingConfiguration()
        config.detectionImages = getReferenceImages()
        config.maximumNumberOfTrackedImages = 3
        config.planeDetection = [.horizontal, .vertical]

        // scene reconstruction will help smooth out generated meshes.
        // need to check that the device supports it first (ex: 4th gen ipad pro)
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
            config.sceneReconstruction = .mesh
        }

        setupImageTracking(arView)
        arView.session.run(config)

        let _ = arView.trackedRaycast(from: arView.center, allowing: .estimatedPlane, alignment: .horizontal) { results in
            // This is where I was going to detect objects that have already been placed
            // in the scene and allow the user to delete them.

            // guard let result: ARRaycastResult = results.first else { return }
        }
        return arView
    }

    // This method gets called by the system whenever @Binding properties like
    // `modelToLoad` are set/updated.
    func updateUIView(_ uiView: ARView, context: Context) {
        guard let modelToLoad else { return }

        let anchor = AnchorEntity(.plane(.horizontal, classification: .any, minimumBounds: SIMD2<Float>(0.2, 0.2)))
        anchor.children.append(modelToLoad.clone(recursive: true))
        uiView.scene.anchors.append(anchor)

        // This allows the same model to be picked twice in a row by the user and loaded two separate times.
        // Otherwise a difference model has to be picked before picking a previous one again
        // since the `updateUIView` method only triggers when the `modelToLoad` property changes
        DispatchQueue.main.async {
            self.modelToLoad = nil
        }
    }

    private func setupImageTracking(_ arView: ARView) {
        let sphere = ModelEntity(mesh: .generateSphere(radius: 0.05))
        let imageAnchor = AnchorEntity(.image(group: "AR Resources", name: "good-contrast"))
        imageAnchor.addChild(sphere)
        sphere.position.z = imageAnchor.position.z - 0.1 // position the model as to not block the view of the image
        arView.scene.anchors.append(imageAnchor)
    }

    private func getReferenceImages() -> Set<ARReferenceImage> {
        guard let referenceImages = ARReferenceImage.referenceImages(
            inGroupNamed: "AR Resources", bundle: nil)
        else {
            return Set<ARReferenceImage>()
        }

        return referenceImages
    }
}
