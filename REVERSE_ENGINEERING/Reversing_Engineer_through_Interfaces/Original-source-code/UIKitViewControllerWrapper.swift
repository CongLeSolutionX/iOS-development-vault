//
//  UIKitViewControllerWrapper.swift
//  MyApp
//
//  Created by Cong Le on 8/19/24.
//
// > This content is dual-licensed under your choice of the following licenses:
// > 1.  **MIT License:** For the code implementations in Swift and Mermaid provided in this document.
// > 2.  **Creative Commons Attribution 4.0 International License (CC BY 4.0):** For all other content, including the text, explanations, and the Mermaid diagrams and illustrations.

// ---

import SwiftUI
import UIKit

struct UIKitViewControllerWrapper: UIViewControllerRepresentable {
    typealias UIViewControllerType = YOLOViewController
    
    func makeUIViewController(context: Context) -> YOLOViewController {
        return YOLOViewController()
    }
    
    func updateUIViewController(_ uiViewController: YOLOViewController, context: Context) {
        // Update the view controller if needed
    }
}

// Example UIKit view controller
class MyUIKitViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        // Additional setup
    }
}
