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
    
    var linkTapActionHandler: ((URL)->())? = nil {
        didSet {
            bannerView.linkTapActionHandler = { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.linkTapActionHandler?(strongSelf.url)
            }
        }
    }
    
    var minimizeActionHandler: ((Bool)->())? = nil {
        didSet {
            bannerView.minimizeActionHandler = { [weak self] (minimized) in
                guard let strongSelf = self else { return }
                strongSelf.update(for: minimized)
                strongSelf.minimizeActionHandler?(minimized)
            }
        }
    }
    
    let bannerView: BannerView
    
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
    
    func setup() {
        setupConstraints()
        bannerView.minimized = UserDefaults.standard.bool(forKey: persistanceMinimizedKey)
        update(for: bannerView.minimized)
    }
    
    func setupConstraints() {
        view.addSubview(bannerView)
        constrain(bannerView) {
            $0.width == $0.superview!.width
            $0.height == $0.superview!.height
        }
    }
}

private extension BannerViewController {
    
    var url: URL {
        return URL(string: "https://www.medium.com/nano")!
    }
    
    var bannerViewText: String {
        return "This is a test banner. It looks pretty awesome! \nPlease see \(url) for details."
    }
    
    var minimizedBannerViewText: String {
        return "This is a test banner."
    }
    
    var persistanceMinimizedKey: String {
        return "BannerViewController.minimized"
    }
    
    func update(for minimized: Bool) {
        bannerView.textView.layer.addFadeTransition()
        bannerView.textView.text = minimized ? minimizedBannerViewText : bannerViewText
        UserDefaults.standard.set(minimized, forKey: persistanceMinimizedKey)
        UserDefaults.standard.synchronize()
    }
}

extension CALayer {
    func addFadeTransition() {
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 0.25
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        add(transition, forKey: kCATransition)
    }
}
