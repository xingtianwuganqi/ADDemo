//
//  AppDelegate.swift
//  ADDemo
//
//  Created by jingjun on 2022/12/17.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow.init(frame: UIScreen.main.bounds)
        let navi = UINavigationController.init(rootViewController: ViewController())
        window.rootViewController = navi
        self.window = window
        window.makeKeyAndVisible()
        registerAD()
        return true
    }
    
    func registerAD() {
        TopADManager.shareInstance.registerAD {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                TopADManager.shareInstance.loadSplashAD()
                TopADManager.shareInstance.loadNativeAD()
                TopADManager.shareInstance.loadNativeAD(nativeID: NATIVEADKEY2)
                TopADManager.shareInstance.loadBannerAD()
                TopADManager.shareInstance.loadRewardVideoAD()
            }
        }
    }

    

}

extension AppDelegate {
    func applicationWillEnterForeground(_ application: UIApplication) {
        
        TopADManager.shareInstance.showSplashAD()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
//        self.registerAD(completion: {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                ZMADManager.shareInstance.loadSplashAD()
//                ZMADManager.shareInstance.loadNativeAD()
//            }
//        })
        // 回到前台，逻辑待完善

    }
}
