//
//  MyApp.swift
//  MyApp
//
//  Created by Cong Le on 8/19/24.
//
// > This content is dual-licensed under your choice of the following licenses:
// > 1.  **MIT License:** For the code implementations in Swift and Mermaid provided in this document.
// > 2.  **Creative Commons Attribution 4.0 International License (CC BY 4.0):** For all other content, including the text, explanations, and the Mermaid diagrams and illustrations.

// ---

import SwiftUI

@main
struct MyApp: App {
    // Monitor the app's scene phase (active, inactive, background)
    @Environment(\.scenePhase) private var scenePhase
    
    init() {
        // Equivalent to application(_:didFinishLaunchingWithOptions:)
        print("App initialized (didFinishLaunchingWithOptions)")
    }
    
    var body: some Scene {
        WindowGroup {
            UIKitContentView()
        }// Respond to changes in the scene phase
        .onChange(of: scenePhase) { oldPhase, newPhase in
            switch newPhase {
            case .active:
                print("Scene became active")
            case .inactive:
                print("Scene became inactive")
            case .background:
                print("Scene entered background")
            @unknown default:
                print("Unknown scene phase")
            }
        }
    }
}
