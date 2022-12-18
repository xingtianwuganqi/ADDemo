//
//  BannerADView.swift
//  ADDemo
//
//  Created by jingjun on 2022/12/18.
//

import UIKit
import BasicProject
import AnyThinkBanner

class BannerADView: UIView {

    var adView: ATBannerView?
        
    let width = SCREEN_WIDTH
    let height = SCREEN_WIDTH
    
    // 加载广告结果：0失败，1成功，3关闭广告
    var loadADFinish: ((Int) -> Void)?
    

    override init(frame: CGRect) {
        super.init(frame: frame)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showBannerAD() {
        let isRead = TopADManager.shareInstance.bannerIsReady()
        if isRead {
            self.subviews.forEach { view in
                view.removeFromSuperview()
            }
            self.adView = nil
            
            guard let bannerView = ATAdManager.shared().retrieveBannerView(forPlacementID: BANNERKEY) else {
                return
            }
            bannerView.delegate = TopADManager.shareInstance
            bannerView.presentingViewController = Tool.shared.TopViewController()
            bannerView.translatesAutoresizingMaskIntoConstraints = false
            bannerView.tag = 101
            
            self.addSubview(bannerView)
            bannerView.frame = CGRect(x: 0, y: 0, width: width, height: height)
            self.adView = bannerView
        }
        
    }
}
