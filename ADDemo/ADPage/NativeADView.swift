//
//  NativeADView.swift
//  LoveCat
//
//  Created by jingjun on 2022/5/26.
//

import UIKit
import BasicProject
import AnyThinkNative
public class NativeADView: UIView {
    var adView: ATNativeADView?
        
    let width = SCREEN_WIDTH
    let height = SCREEN_WIDTH * 265 / 375

    override init(frame: CGRect) {
        super.init(frame: frame)
    
    }
    
    public func showAD(nativeID: String = NATIVEADKEY) {
        let isReady = TopADManager.shareInstance.nativeIsReady()
        if isReady {

            let config = ATNativeADConfiguration.init()
            config.adFrame = CGRect(x: 0, y: 0, width: width, height: height)
            config.delegate = TopADManager.shareInstance
            config.sizeToFit = true
            config.rootViewController = Tool.shared.TopViewController()

            guard let offer = ATAdManager.shared().getNativeAdOffer(withPlacementID: nativeID) else {
                return
            }

            guard let nativeADView = ATNativeADView.init(configuration: config, currentOffer: offer, placementID: nativeID) else {
                return
            }
            self.subviews.forEach { view in
                view.removeFromSuperview()
            }
            self.adView = nil
            
            let nativeADRenderType = nativeADView.getCurrentNativeAdRenderType()
            if nativeADRenderType == .express {
                // 原始模板
                printLog("原始模板")
            }else{
                printLog("原生自渲染")

            }

            //渲染广告
            offer.renderer(with: config, selfRenderView: nil, nativeADView: nativeADView)
            
            self.addSubview(nativeADView)
            nativeADView.frame = CGRect(x: 0, y: 0, width: width, height: height)
            self.adView = nativeADView
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


