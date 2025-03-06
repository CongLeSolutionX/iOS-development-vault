//
//  ContentView.swift
//  MyApp
//
//  Created by Cong Le on 8/19/24.
//
// > This content is dual-licensed under your choice of the following licenses:
// > 1.  **MIT License:** For the code implementations in Swift and Mermaid provided in this document.
// > 2.  **Creative Commons Attribution 4.0 International License (CC BY 4.0):** For all other content, including the text, explanations, and the Mermaid diagrams and illustrations.

// ---

import SwiftUI

// Step 2: Use in SwiftUI view
struct RootContentView: View {
    var body: some View {
        Text("Hello World from SwiftUI View!")
            .onAppear {
                print("View.onAppear()")
            }
            .onDisappear {
                print("View.onDisappear()")
            }
    }
}

struct UIKitContentView: View {
    var body: some View {
        UIKitViewControllerWrapper()
            .edgesIgnoringSafeArea(.all)
    }
}

// Before iOS 17, use this syntax for preview UIKit view controller
struct UIKitViewControllerWrapper_Previews: PreviewProvider {
    static var previews: some View {
        UIKitViewControllerWrapper()
    }
}

// After iOS 17, we can use this syntax for preview:
#Preview {
    RootContentView()
}
