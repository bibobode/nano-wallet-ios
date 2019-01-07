//
//  BannerView.swift
//  Raiblocks
//
//  Created by Fawaz Tahir on 1/6/19.
//  Copyright © 2019 Zack Shapiro. All rights reserved.
//

import Foundation
import Cartography

class BannerView: UIView {
    
    var text: String = "" {
        didSet {
            textView.text = text
        }
    }
    
    private let textView = UITextView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension BannerView {
    
    func setup() {
        setupConstraints()
        setup(textView: textView)
    }
    
    func setupConstraints() {
        addSubview(textView)
        constrain(textView) {
            $0.width == $0.superview!.width
            $0.height == $0.superview!.height
        }
    }
    
    func setup(textView: UITextView) {
        textView.textContainerInset = UIEdgeInsetsMake(12, 12, 12, 12)
        textView.dataDetectorTypes = [.link]
        textView.textAlignment = .left
        textView.isUserInteractionEnabled = false
        textView.isEditable = false
        textView.backgroundColor = Styleguide.Colors.lime.color
        textView.font = Styleguide.Fonts.nunitoRegular.font(ofSize: 16)
        textView.textColor = Styleguide.Colors.darkBlue.color
        textView.isSelectable = true
        textView.isScrollEnabled = true
    }
}
