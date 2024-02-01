# 3DModelPicker
Uses RealityKit and SwiftUI to load 3D models in an AR scene

# To use to app

## Model Picker
1. Tap anywhere on the screen to display the model picker UI
2. Swipe left or right to view the available models
3. Tap on the image of the model to load it on a horizontal surface in the scene

## Image Tracking

1. Display the image named "good-contrast.jpg" on a computer screen
<img src=[good-contrast](https://github.com/tobinP/3DModelPicker/assets/12635217/7102b3e4-cb84-4b4f-b721-0c396f5cac04) width=400>

2. Point the display that the image and see the 3D pink sphere display above the image

I found an image online with characteristics that are friendly to image tracking (a sunset over the sea).
This made for a solid image tracking experience.

Originally I was hoping to use each of the USDZ model thumbnails as the images to track and then load their
respective 3D models but they don't have good tracking characteristcs and it made for a poor tracking experience.

# Considerations

In the spirit of doing as much as possible in RealityKit and not directly in ARKit, the image tracking was setup 
using AnchorEntity(.image()) which is way nicer syntax than setting up all of ARKit’s session delegate methods.

# Extra features if this project were to be expanded

- Use RealityKit's Entity Component System to add animations and other behvaviors to the 3D models in the scene
- Use `arView.trackedRaycast()` to perform raycasts on a loop in order to identitify 3D models in the scene and present the user with the option to delete them
- Use that same raycast setup to display a reticle on the surfaces where 3D models are allowed to be placed. This is just a general UX improvememnt.
