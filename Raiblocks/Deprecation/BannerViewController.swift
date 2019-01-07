//
//  BannerViewController.swift
//  Raiblocks
//
//  Created by Fawaz Tahir on 1/6/19.
//  Copyright © 2019 Zack Shapiro. All rights reserved.
//

import Foundation
import Cartography

class BannerViewController: UIViewController {
    
    private let bannerView: BannerView
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        bannerView = BannerView(frame: .zero)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

private extension BannerViewController {
    
    var bannerViewText: String {
        return "This app will soon be deprecated.\nPlease see https://www.medium.com/nano for alternatives and details."
    }
    
    func setup() {
        view.addSubview(bannerView)
        setupConstraints()
        bannerView.text = bannerViewText
    }
    
    func setupConstraints() {
        constrain(bannerView) {
            $0.width == $0.superview!.width
            $0.height == $0.superview!.height
        }
    }
    
}
