//
//  ActivityView.swift
//  ProUISwift
//
//  Created by Mustafa Bekirov on 11.05.2023.
//

import SwiftUI

struct ActivityView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIActivityViewController
    public var activityItems: [Any]
    public var applicationActivityes: [UIActivity]?
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let vc = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivityes)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
