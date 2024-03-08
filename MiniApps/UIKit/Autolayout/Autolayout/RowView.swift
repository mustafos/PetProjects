//
//  RowView.swift
//  Autolayout
//
//  Created by Mustafa Bekirov on 16.01.2024.
//

import UIKit

class RowView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        let titleLabel = makeLabel(withText: "Gapless Playback")
        let onOffSwith = makeSwitch(isOn: true)

        addSubview(titleLabel)
        addSubview(onOffSwith)

        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        
        onOffSwith.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        onOffSwith.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 31)
    }
    
}
