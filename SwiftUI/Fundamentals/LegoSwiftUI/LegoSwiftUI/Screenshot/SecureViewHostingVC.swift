//
//  SecureViewHostingVC.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 12.03.2024.
//

import UIKit
import SwiftUI

final class SecureViewHostingVC<Content: View>: UIViewController {
    
    private let content: () -> Content
    private let secureView = ScreenshotPreventationView()
    
    var preventSecureCapture: Bool = true {
        didSet {
            secureView.preventScreenCapture = preventSecureCapture
        }
    }
    
    init(preventScreenCapture: Bool, @ViewBuilder content: @escaping () -> Content) {
        self.preventSecureCapture = preventScreenCapture
        self.content = content
        super.init(nibName: nil, bundle: nil)
        
        setupUI()
        secureView.preventScreenCapture = preventScreenCapture
    }
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder: ) has not beeb implemented")
    }
    
    private func setupUI() {
        view.addSubview(secureView)
        secureView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            secureView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            secureView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            secureView.topAnchor.constraint(equalTo: view.topAnchor),
            secureView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let hostVC = UIHostingController(rootView: content())
        hostVC.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(hostVC)
        secureView.setup(contentView: hostVC.view)
        hostVC.didMove(toParent: self)
    }
}

struct SecureView<Content: View>: UIViewControllerRepresentable {
    
    private var preventScreenCapture: Bool
    private let content: () -> Content
    
    init(preventScreenCapture: Bool, @ViewBuilder content: @escaping () -> Content) {
        self.preventScreenCapture = preventScreenCapture
        self.content = content
    }
    
    func makeUIViewController(context: Context) -> SecureViewHostingVC<Content> {
            SecureViewHostingVC(preventScreenCapture: preventScreenCapture, content: content)
    }
    
    func updateUIViewController(_ uiViewController: SecureViewHostingVC<Content>, context: Context) {
        uiViewController.preventSecureCapture = preventScreenCapture
    }
}
