//
//  SendingViewController.swift
//  TipCalculator
//
//  Created by Mustafa Bekirov on 04.01.2024.
//

import UIKit
import SwiftUI

struct CategoryPickerView: View {
    @State private var selectedCategory: String?
    let categories = ["Beverages", "Food", "Condiments", "Desserts"]
    let onSelected: (String) -> Void
    
    var body: some View {
        Picker("Categories", selection: $selectedCategory) {
            ForEach(categories, id: \.self) { category in
                Text(category).tag(Optional(category))
            }
        }
        .pickerStyle(.wheel)
        .onChange(of: selectedCategory) { category in
            if let category {
                onSelected(category)
            }
        }
    }
}

class SendingViewController: UIViewController {
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Category Label"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var categoryPickerView: CategoryPickerView = {
        let pickerView = CategoryPickerView { [weak self] category in
            self?.categoryLabel.text = category
        }
        
        return pickerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.purple
        
        let hostingController = UIHostingController(rootView: categoryPickerView)
        view.addSubview(categoryLabel)
        view.addSubview(hostingController.view)
        self.addChild(hostingController)
        hostingController.didMove(toParent: self)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        hostingController.view.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        categoryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        categoryLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
    }
}

struct ViewControllerRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        SendingViewController()
    }
}

struct SendingViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable()
    }
}
