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
            set(text: text, for: textView)
        }
    }
    
    let textView = UITextView(frame: .zero)
    
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
        constrain(textView) {
            $0.width == $0.superview!.width
            $0.height == $0.superview!.height
        }
    }
    
    func setup(textView: UITextView) {
        let padding: CGFloat = 10
        textView.contentInset = UIEdgeInsetsMake(padding, padding, padding, padding)
        textView.dataDetectorTypes = [.link]
        textView.textAlignment = .left
        textView.isUserInteractionEnabled = false
        textView.isEditable = false
        textView.isSelectable = true
        textView.isScrollEnabled = true
    }
}

private extension BannerView {
    
    func set(text: String, for textView: UITextView) {
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.foregroundColor,
                                    value: Styleguide.Colors.darkBlue.color,
                                    range: NSMakeRange(0, attributedText.length))
        attributedText.addAttribute(.font,
                                    value: Styleguide.Fonts.nunitoRegular.font(ofSize: 16),
                                    range: NSMakeRange(0, attributedText.length))
        //        attributedText.addAttribute(.foregroundColor, value: Styleguide.Colors.red.color, range: NSMakeRange(192, 119)) // Middle sentence "We do not have access..."
        //        attributedText.addAttribute(.foregroundColor, value: Styleguide.Colors.red.color, range: NSMakeRange(attributedText.length - 42, 42)) // last sentence "Never give it..."
        
        textView.attributedText = attributedText
    }
}
