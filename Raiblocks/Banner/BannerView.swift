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
    
    var linkTapActionHandler: (()->())? = nil
    var minimizeActionHandler: ((Bool)->())? = nil
    
    let textView = UITextView(frame: .zero)
    
    private let button = UIButton(type: .custom)
    
    private(set) var minimized: Bool = false {
        didSet {
            update(for: minimized)
        }
    }
    
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
        setup(button: button)
        textView.delegate = self
        
        backgroundColor = Styleguide.Colors.lime.color
        update(for: minimized)
    }
    
    func setupConstraints() {
        addSubview(textView)
        addSubview(button)
        
        constrain(textView, button) {
            $0.left == $0.superview!.left
            $0.right == $1.left
            $0.height == $0.superview!.height
        }
        
        constrain(button) {
            $0.right == $0.superview!.right - 5
            $0.top == $0.superview!.top + 5
            $0.width == CGFloat(35)
            $0.height == CGFloat(35)
        }
    }
    
    func setup(button: UIButton) {
        button.imageView?.contentMode = .scaleAspectFit
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func setup(textView: UITextView) {
        textView.textContainerInset = UIEdgeInsetsMake(12, 12, 12, 12)
        textView.dataDetectorTypes = [.link]
        textView.textAlignment = .left
        textView.isEditable = false
        textView.font = Styleguide.Fonts.nunitoRegular.font(ofSize: 16)
        textView.textColor = Styleguide.Colors.darkBlue.color
        textView.isSelectable = true
        textView.isScrollEnabled = true
        textView.backgroundColor = .clear
    }
}

private extension BannerView {
    func update(for minimized: Bool) {
        let image = minimized ? UIImage(named: "maximizeIcon") : UIImage(named: "minimizeIcon")
        button.layer.addFadeTransition()
        button.setImage(image, for: .normal)
    }
    
    @objc func buttonTapped() {
        minimized = minimized == false
        minimizeActionHandler?(minimized)
    }
}

extension BannerView: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        linkTapActionHandler?()
        return false
    }
    
    func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return false
    }
}
