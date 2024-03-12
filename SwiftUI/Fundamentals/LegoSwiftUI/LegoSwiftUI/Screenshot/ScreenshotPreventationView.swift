//
//  ScreenshotPreventation.swift
//  LegoSwiftUI
//
//  Created by Mustafa Bekirov on 12.03.2024.
//

import UIKit

public final class ScreenshotPreventationView: UIView {
    
    private var contentView: UIView?
    private let textField = UITextField()
    private lazy var secureViewController: UIView? = try? getSecureViewController()
    // This hidden view incorporate main view
    
    public var preventScreenCapture = true {
        didSet {
            textField.isSecureTextEntry = preventScreenCapture
        }
    }
    
    public override var isUserInteractionEnabled: Bool {
        didSet {
            secureViewController?.isUserInteractionEnabled = isUserInteractionEnabled
        }
    }
    
    public init(contentView: UIView? = nil) {
        self.contentView = contentView
        super.init(frame: .zero)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func getSecureViewController() throws -> UIView? {
        return textField.subviews.filter { subView in
            type(of: subView).description() == "_UITextLayoutCanvasView"
        }.first
    }
    
    private func setupUI() {
        textField.backgroundColor = .clear
        textField.isUserInteractionEnabled = false
        
        guard let viewController = secureViewController else { return }
        
        addSubview(viewController)
        viewController.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            viewController.leadingAnchor.constraint(equalTo: leadingAnchor),
            viewController.trailingAnchor.constraint(equalTo: trailingAnchor),
            viewController.topAnchor.constraint(equalTo: topAnchor),
            viewController.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    public func setup(contentView: UIView) {
        self.contentView?.removeFromSuperview()
        self.contentView = contentView
        
        guard let viewContrller = secureViewController else { return }
        viewContrller.addSubview(contentView)
        
        viewContrller.isUserInteractionEnabled = isUserInteractionEnabled
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let bottomConstraint = contentView.bottomAnchor.constraint(equalTo: viewContrller.bottomAnchor)
        bottomConstraint.priority = .required - 1
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: viewContrller.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: viewContrller.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: viewContrller.topAnchor),
            bottomConstraint
        ])
    }
}
