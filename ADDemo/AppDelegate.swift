//
//  AppDelegate.swift
//  ADDemo
//
//  Created by jingjun on 2022/12/17.
//

import UIKit
import BasicProject

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var firstLoad: Bool = true

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
                TopADManager.shareInstance.loadAllAD()
            }
        }
    }

    

}

extension AppDelegate {
    func applicationWillEnterForeground(_ application: UIApplication) {
        TopADManager.shareInstance.showSplashAD()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        if firstLoad {
            firstLoad = false
        }else{
            TopADManager.shareInstance.loadAllAD()
        }
    }
}
