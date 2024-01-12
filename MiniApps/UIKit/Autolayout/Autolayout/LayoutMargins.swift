//
//  LayoutMargins.swift
//  Autolayout
//
//  Created by Mustafa Bekirov on 07.01.2024.
//

import UIKit

class LayoutMargins: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() -> Void {
        
        // create controls
        let leadingGuid = UILayoutGuide()
        let okButton = makeButton(title: "OK", color: UIColor.darkBlue)
        let middleGuide = UILayoutGuide()
        let cancelButton = makeButton(title: "Cancel", color: UIColor.darkGreen)
        let trailingGuide = UILayoutGuide()
        
        // add to subview & layout guide
        view.addSubview(okButton)
        view.addSubview(cancelButton)
        view.addLayoutGuide(leadingGuid)
        view.addLayoutGuide(middleGuide)
        view.addLayoutGuide(trailingGuide)
        
        // setuo constraints
        let margins = view.layoutMarginsGuide
        
        // leading guide
        margins.leadingAnchor.constraint(equalTo: leadingGuid.leadingAnchor).isActive = true
        leadingGuid.trailingAnchor.constraint(equalTo: okButton.leadingAnchor).isActive = true
        
        // middle guide
        okButton.trailingAnchor.constraint(equalTo: middleGuide.leadingAnchor).isActive = true
        middleGuide.trailingAnchor.constraint(equalTo: cancelButton.leadingAnchor).isActive = true
        
        // trailing guide
        cancelButton.trailingAnchor.constraint(equalTo: trailingGuide.leadingAnchor).isActive = true
        trailingGuide.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        
        // button equal widths
        okButton.widthAnchor.constraint(equalTo: cancelButton.widthAnchor).isActive = true
        
        // spacer equal widths
        leadingGuid.widthAnchor.constraint(equalTo: middleGuide.widthAnchor).isActive = true
        leadingGuid.widthAnchor.constraint(equalTo: trailingGuide.widthAnchor).isActive = true
        
        // verticle position
        leadingGuid.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        middleGuide.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        trailingGuide.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        okButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        cancelButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        // giving layout guides default height
        leadingGuid.heightAnchor.constraint(equalToConstant: 1).isActive = true
        middleGuide.heightAnchor.constraint(equalToConstant: 1).isActive = true
        trailingGuide.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}
