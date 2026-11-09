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

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private var firstActivation = true

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UINavigationController(rootViewController: ViewController())
        self.window = window
        (UIApplication.shared.delegate as? AppDelegate)?.window = window
        window.makeKeyAndVisible()
        (UIApplication.shared.delegate as? AppDelegate)?.registerAD()
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        guard !firstActivation else { return }
        TopADManager.shareInstance.showSplashAD(vc: Tool.shared.TopViewController())
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        if firstActivation {
            firstActivation = false
        } else {
            TopADManager.shareInstance.loadAllAD()
        }
    }
}

extension AppDelegate {
    func applicationWillEnterForeground(_ application: UIApplication) {
        TopADManager.shareInstance.showSplashAD(vc: Tool.shared.TopViewController())
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        if firstLoad {
            firstLoad = false
        }else{
            TopADManager.shareInstance.loadAllAD()
        }
    }
}
