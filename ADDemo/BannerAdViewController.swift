//
//  BannerAdViewController.swift
//  ADDemo
//
//  Created by jingjun on 2022/12/18.
//

import UIKit
import BasicProject
import AnyThinkBanner

class BannerAdViewController: UIViewController {
    
    lazy var bannerAdView : BannerADView = {
        let backview = BannerADView.init()
        backview.backgroundColor = .white
        return backview
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(bannerAdView)
        self.showBannerView()
    }
    
    
    
    func showBannerView() {
        self.bannerAdView.showBannerAD()
    }
    
}
