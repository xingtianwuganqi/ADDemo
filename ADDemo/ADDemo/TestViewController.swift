//
//  TestViewController.swift
//  LoveCat
//
//  Created by jingjun on 2021/7/28.
//

import UIKit
import BasicProject
import AnyThinkNative
import MBProgressHUD

class TestViewController: UIViewController {
    
    let width = SCREEN_WIDTH
    let height = SCREEN_WIDTH * 265 / 375
    
    lazy var showAdView : ShowADView = {
        let backview = ShowADView.init(frame: CGRect(x: 0, y: SystemNavigationBarHeight, width: width, height: height))
        backview.backgroundColor = .white
        return backview
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(showAdView)
        if TopADManager.shareInstance.nativeIsReady() {
            printLog("=-=-=-=-=-=-=-=-=")
            printLog("ISREADY")
        }else{
            TopADManager.shareInstance.loadNativeAD()
        }

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.showNativeAD()
    }
    

    deinit {
        printLog("Test Deinit")
    }
    
    func showNativeAD() {
        showAdView.showAD(rootVC: self)
    }
}
