//
//  ADManager.swift
//  LoveCat
//
//  Created by jingjun on 2022/5/28.
//

import UIKit
import Foundation
import BasicProject
import AnyThinkSDK
import AppTrackingTransparency
import AnyThinkSplash
import AnyThinkNative
import AnyThinkRewardedVideo
import AnyThinkBanner
import AnyThinkInterstitial

public let ADAPPID = "a628a37c6257cf"
public let ADAPPKEY = "34957f626411ed7ac73916e8b4031128"
public let NATIVEADKEY = "b639c3454a57c3"
public let NATIVEADKEY2 = "b628e3b04c9f7a"
public let SPLASHKEY = "b628a391c9712a"
public let REWARDVIDEOKEY = "b628a396ea0887"
public let BANNERKEY = "b639ef04a6951e"
public let INTERSTITIALKEY = "b628a3952eb140"


public class TopADManager: NSObject {
    
    static let shareInstance = TopADManager()
    
    private override init() {
        
    }
    
    lazy var skipButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        button.frame = CGRect(x: SCREEN_WIDTH - 80 - 20, y: SystemNavigationBarHeight - 10, width: 80, height: 26)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 13
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    
    /// 广告加载完成回调
    public var adDidLoadFinishCallBack: ((String) -> Void)?
    /// 激励视频激励回调
    public var rewardVideoRewardSuccess: (() -> Void)?
    
    /// 选择关闭回调
    public var nativeADClose: ((String,Int) -> Void)?
    
    /// 激励广告加载状态: 0 加载失败，加载成功
    public var rewardVideoLoaded: Int?
    
    
    public func registerAD(completion: (() -> Void)?) {
        #if DEBUG
        ATAPI.setLogEnabled(true)
        #endif
        // 检查广告完整性
        ATAPI.integrationChecking()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if #available(iOS 14.0, *) {
                ATTrackingManager.requestTrackingAuthorization { status in
                    try? ATAPI.sharedInstance().start(withAppID: ADAPPID, appKey: ADAPPKEY)
                    completion?()
                }
            }else{
                try? ATAPI.sharedInstance().start(withAppID: ADAPPID, appKey: ADAPPKEY)
                completion?()
            }
        }
    }
    
    // MARK: - 开屏广告
    public func loadSplashAD() {
        
        if  let status = ATAdManager.shared().checkSplashLoadStatus(forPlacementID: SPLASHKEY), (status.isReady == true || status.isLoading == true) {
            return
        }
        
        let label = UILabel.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 100))
        label.backgroundColor = UIColor.color(.system)
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        label.text = "真命天喵"
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        
        let defaultADSourceStr = "{\"unit_id\":1830551,\"ad_type\":-1,\"nw_firm_id\":15,\"adapter_class\":\"ATTTSplashAdapter\",\"content\":\"{\\\"slot_id\\\":\\\"887788936\\\",\\\"personalized_template\\\":\\\"0\\\",\\\"zoomoutad_sw\\\":\\\"1\\\",\\\"button_type\\\":\\\"0\\\",\\\"dl_type\\\":\\\"0\\\",\\\"app_id\\\":\\\"5296075\\\"}\"}"
        let extra: [String: Any] = [
            kATExtraInfoRootViewControllerKey: Tool.shared.TopViewController(),
            kATSplashExtraTolerateTimeoutKey: 4]
        ATAdManager.shared().loadAD(withPlacementID: SPLASHKEY, extra: extra, delegate: self, containerView: label, defaultAdSourceConfig: defaultADSourceStr)
    }
    
    // MARK: 开屏广告是否准备好
    public func splashIsReady() -> Bool {
        return ATAdManager.shared().splashReady(forPlacementID: SPLASHKEY)
    }
    
    // MARK: 展示开屏广告
    public func showSplashAD() {
        if (ATAdManager.shared().splashReady(forPlacementID: SPLASHKEY)) {
            let window: UIWindow?
            if #available(iOS 13.0, *) {
                window = UIApplication.shared.windows.first
            }else{
                window = UIApplication.shared.keyWindow
            }
            let extra: [String: Any] = [
                kATSplashExtraCountdownKey: 5000,
      kATSplashExtraCustomSkipButtonKey: self.skipButton,
     kATSplashExtraCountdownIntervalKey: 500]
            ATAdManager.shared().showSplash(withPlacementID: SPLASHKEY, scene: "", window: window, extra: extra, delegate: self)
        }else{
            guard  let status = ATAdManager.shared().checkSplashLoadStatus(forPlacementID: SPLASHKEY), (status.isReady != true || status.isLoading != true) else {
                return
            }
        
            self.loadSplashAD()
        }
    }
    
    // MARK: - 加载native广告
    public func loadNativeAD(nativeID: String = NATIVEADKEY) {

        if let status = ATAdManager.shared().checkNativeLoadStatus(forPlacementID: nativeID), (status.isReady == true || status.isLoading == true) {
            return
        }
        
        let extra: [String: Any] = [
            kATExtraInfoNativeAdSizeKey: CGSize(width: 375, height: 265),
            kATNativeAdSizeToFitKey: true
        ]

        ATAdManager.shared().loadAD(withPlacementID: nativeID, extra: extra, delegate: self)
    }
    
    // MARK: native广告是否加载完成
    public func nativeIsReady(nativeID: String = NATIVEADKEY) -> Bool{
        return ATAdManager.shared().nativeAdReady(forPlacementID: nativeID)
    }

    //MARK: - 视频激励广告
    public func loadRewardVideoAD() {
        if let status = ATAdManager.shared().checkRewardedVideoLoadStatus(forPlacementID: REWARDVIDEOKEY), (status.isReady == true || status.isLoading == true) {
            return
        }

        let extra: [String: Any] = [
            kATAdLoadingExtraMediaExtraKey:"media_val", kATAdLoadingExtraUserIDKey:"rv_test_user_id",kATAdLoadingExtraRewardNameKey:"reward_Name",kATAdLoadingExtraRewardAmountKey:3,
                kATExtraInfoRootViewControllerKey:Tool.shared.TopViewController(),
        ]
        ATAdManager.shared().loadAD(withPlacementID: REWARDVIDEOKEY, extra: extra, delegate: self)
    }


    // MARK: 激励视频是否准备好
    public func rewardVideoAdIsReady() -> Bool {
        return ATAdManager.shared().rewardedVideoReady(forPlacementID: REWARDVIDEOKEY)
    }

    // MARK: 展示视频广告
    public func showRewardVideoAD() {
        if ATAdManager.shared().rewardedVideoReady(forPlacementID: REWARDVIDEOKEY) {
            ATAdManager.shared().showRewardedVideo(withPlacementID: REWARDVIDEOKEY, in: Tool.shared.TopViewController(), delegate: self)
        }else{
            guard  let status = ATAdManager.shared().checkRewardedVideoLoadStatus(forPlacementID: REWARDVIDEOKEY), (status.isReady != true || status.isLoading != true) else {
                return
            }
            self.loadRewardVideoAD()
        }
    }
    
    // MARK: - banner位广告
    public func loadBannerAD() {
        let status = ATAdManager.shared().checkBannerLoadStatus(forPlacementID: BANNERKEY)
        if (status.isReady == true || status.isLoading == true) {
            return
        }
        let extra: [String: Any] = [
            kATAdLoadingExtraBannerAdSizeKey: CGSize(width: SCREEN_WIDTH, height: 250)
        ]
        ATAdManager.shared().loadAD(withPlacementID: BANNERKEY, extra:extra , delegate: self)
    }
    
    // MARK: banner位广告是否准备好
    public func bannerIsReady() -> Bool {
        return ATAdManager.shared().bannerAdReady(forPlacementID: BANNERKEY)
    }
    
    // MARK: 展示banner位广告
    public func showBannerAD() {
        if ATAdManager.shared().bannerAdReady(forPlacementID: BANNERKEY) {
//            ATAdManager.shared().show
        }else{
            let status = ATAdManager.shared().checkBannerLoadStatus(forPlacementID: BANNERKEY)
            if (status.isReady != true || status.isLoading != true) {
                return
            }
            self.loadBannerAD()
        }
    }
    
    // MARK: 插屏广告
    public func loadInterstitialAD() {
        if let status = ATAdManager.shared().checkInterstitialLoadStatus(forPlacementID: INTERSTITIALKEY), (status.isReady == true || status.isLoading == true) {
            return
        }
        let extra: [String: Any] = [
            kATInterstitialExtraAdSizeKey: CGSize(width: SCREEN_WIDTH - 30, height: 300)
        ]
        ATAdManager.shared().loadAD(withPlacementID: INTERSTITIALKEY, extra:extra , delegate: self)
    }
    
    // MARK: 插屏广告是否准备好
    public func interstitialADIsReady() -> Bool {
        return ATAdManager.shared().interstitialReady(forPlacementID: INTERSTITIALKEY)
    }
    
    // MARK: 展示插屏广告
    public func showInterstitialAD() {
        if ATAdManager.shared().interstitialReady(forPlacementID: INTERSTITIALKEY){
            ATAdManager.shared().showInterstitial(withPlacementID: INTERSTITIALKEY, in: Tool.shared.TopViewController(), delegate: self)
        }else{
            let status = ATAdManager.shared().checkBannerLoadStatus(forPlacementID: BANNERKEY)
            if (status.isReady != true || status.isLoading != true) {
                return
            }
            self.loadBannerAD()
        }
    }
}

// MARK: 开屏广告代理
extension TopADManager: ATSplashDelegate {
    public func splashDidShow(forPlacementID placementID: String!, extra: [AnyHashable : Any]!) {
        if !TopADManager.shareInstance.splashIsReady() {
            TopADManager.shareInstance.loadSplashAD()
        }
    }
    
    public func splashDidClick(forPlacementID placementID: String!, extra: [AnyHashable : Any]!) {
        
    }
    
    public func splashDidClose(forPlacementID placementID: String!, extra: [AnyHashable : Any]!) {
        
    }
    
    public func splashCountdownTime(_ countdown: Int, forPlacementID placementID: String!, extra: [AnyHashable : Any]!) {
        // 倒计时
        DispatchQueue.main.async {
            let title = String(format: "%lds | 跳过", countdown / 1000)
            if ((countdown/1000) != 0) {
                self.skipButton.setTitle(title, for: .normal)
            }
        }
    }

    public func splashDeepLinkOrJump(forPlacementID placementID: String!, extra: [AnyHashable : Any]!, result success: Bool) {

    }

    public func splashDetailDidClosed(forPlacementID placementID: String!, extra: [AnyHashable : Any]!) {

    }

    public func splashZoomOutViewDidClick(forPlacementID placementID: String!, extra: [AnyHashable : Any]!) {

    }

    public func splashZoomOutViewDidClose(forPlacementID placementID: String!, extra: [AnyHashable : Any]!) {

    }
    
    // 公用的方法
    public func didFinishLoadingAD(withPlacementID placementID: String!) {
        if placementID == SPLASHKEY {
            printLog("========== 开屏广告加载成功")
        }else if placementID == REWARDVIDEOKEY {
            rewardVideoLoaded = 1
            printLog("========== 视频广告加载成功")
        }else if placementID == NATIVEADKEY {
            printLog("========== 原生广告加载成功")
        }
        adDidLoadFinishCallBack?(placementID)
    }
    
    public func didFailToLoadAD(withPlacementID placementID: String!, error: Error!) {
        printLog("广告加载失败 --- \(error.localizedDescription)")
        if placementID == SPLASHKEY {
            printLog("========== 开屏广告加载失败")
        }else if placementID == REWARDVIDEOKEY {
            rewardVideoLoaded = 0
            printLog("========== 视频广告加载失败")
        }else if placementID == NATIVEADKEY {
            // 失败后会不停的加载，这里不再加载
            printLog("========== 原生广告加载失败")
        }
    }
    
}

// MARK: 激励视频广告代理
extension TopADManager: ATRewardedVideoDelegate {
    public func rewardedVideoDidStartPlaying(forPlacementID placementID: String!, extra: [AnyHashable : Any]!) {
        // 重新加载视频
        if !TopADManager.shareInstance.rewardVideoAdIsReady() {
            self.loadRewardVideoAD()
        }
    }
    
    public func rewardedVideoDidEndPlaying(forPlacementID placementID: String!, extra: [AnyHashable : Any]!) {
        
    }
    
    // 播放失败，直接让
    public func rewardedVideoDidFailToPlay(forPlacementID placementID: String!, error: Error!, extra: [AnyHashable : Any]!) {
        self.rewardVideoRewardSuccess?()
    }
    
    public func rewardedVideoDidClose(forPlacementID placementID: String!, rewarded: Bool, extra: [AnyHashable : Any]!) {
        
    }
    
    public func rewardedVideoDidClick(forPlacementID placementID: String!, extra: [AnyHashable : Any]!) {
        
    }
    // 激励成功
    public func rewardedVideoDidRewardSuccess(forPlacemenID placementID: String!, extra: [AnyHashable : Any]!) {
        // 激励成功
        self.rewardVideoRewardSuccess?()
    }
    
    public func rewardedVideoDidDeepLinkOrJump(forPlacementID placementID: String!, extra: [AnyHashable : Any]!, result success: Bool) {
        
    }
    
    public func rewardedVideoAgainDidStartPlaying(forPlacementID placementID: String!, extra: [AnyHashable : Any]!) {
        
    }
    
    public func rewardedVideoAgainDidEndPlaying(forPlacementID placementID: String!, extra: [AnyHashable : Any]!) {
        
    }
    
    public func rewardedVideoAgainDidFailToPlay(forPlacementID placementID: String!, error: Error!, extra: [AnyHashable : Any]!) {
        printLog("VideoAgain Error\(error.localizedDescription)")
    }
    
    public func rewardedVideoAgainDidClick(forPlacementID placementID: String!, extra: [AnyHashable : Any]!) {
        
    }
    
    // 再看一次激励成功
    public func rewardedVideoAgainDidRewardSuccess(forPlacemenID placementID: String!, extra: [AnyHashable : Any]!) {
        self.rewardVideoRewardSuccess?()
    }
}

// MARK: 原生广告代理
extension TopADManager: ATNativeADDelegate {
    public func didShowNativeAd(in adView: ATNativeADView!, placementID: String!, extra: [AnyHashable : Any]!) {
        if !TopADManager.shareInstance.nativeIsReady(nativeID: placementID) {
            TopADManager.shareInstance.loadNativeAD(nativeID: placementID)
        }
    }
    
    public func didClickNativeAd(in adView: ATNativeADView!, placementID: String!, extra: [AnyHashable : Any]!) {
        
    }
    
}

// MARK: banner广告代理
extension TopADManager: ATBannerDelegate {
    public func bannerView(_ bannerView: ATBannerView!, didShowAdWithPlacementID placementID: String!, extra: [AnyHashable : Any]!) {
        if !TopADManager.shareInstance.bannerIsReady() {
            TopADManager.shareInstance.loadBannerAD()
        }
    }
    
    public func bannerView(_ bannerView: ATBannerView!, didClickWithPlacementID placementID: String!, extra: [AnyHashable : Any]!) {
        
    }
}

extension TopADManager: ATInterstitialDelegate {
    public func interstitialDidShow(forPlacementID placementID: String!, extra: [AnyHashable : Any]!) {
        if !TopADManager.shareInstance.interstitialADIsReady() {
            TopADManager.shareInstance.loadInterstitialAD()
        }
    }
    
    public func interstitialDidClick(forPlacementID placementID: String!, extra: [AnyHashable : Any]!) {
        
    }
    
    public func interstitialDidClose(forPlacementID placementID: String!, extra: [AnyHashable : Any]!) {
        
    }
    
    
}
