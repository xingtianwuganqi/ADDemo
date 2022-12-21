//
//  ViewController.swift
//  ADDemo
//
//  Created by jingjun on 2022/12/17.
//

import UIKit
import MBProgressHUD

class ViewController: UIViewController {
    
    lazy var tableView : UITableView = {
        let tableview = UITableView.init(frame: .zero, style: .grouped)
        tableview.backgroundColor = .white
        tableview.showsVerticalScrollIndicator = false
        tableview.showsHorizontalScrollIndicator = false
        tableview.estimatedRowHeight = 0
        tableview.estimatedSectionFooterHeight = 0
        tableview.estimatedSectionHeaderHeight = 0
        tableview.separatorStyle = .none
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        return tableview
    }()
    
    var list = ["开屏广告","banner广告", "插屏广告", "信息流广告1（图片）", "信息流广告2", "激励视频"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        addViews()
    }
    
    func addViews() {
        self.view.addSubview(tableView)
        tableView.frame = view.bounds
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell",for: indexPath)
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let text = list[indexPath.row]
        switch text {
        case "开屏广告":
            if TopADManager.shareInstance.splashIsReady() {
                TopADManager.shareInstance.showSplashAD()
            }else{
                MBProgressHUD.xy_show("开屏广告未加载完成")
                TopADManager.shareInstance.loadSplashAD()
            }
        case "插屏广告":
            if TopADManager.shareInstance.interstitialADIsReady() {
                TopADManager.shareInstance.showInterstitialAD()
            }else{
                MBProgressHUD.xy_show("插屏广告未加载完成")
                TopADManager.shareInstance.loadInterstitialAD()
            }
            break
        case "banner广告":
            if TopADManager.shareInstance.bannerIsReady() {
                let test = BannerAdViewController()
                self.navigationController?.pushViewController(test, animated: true)
            }else{
                MBProgressHUD.xy_show("banner广告未加载完成")
                TopADManager.shareInstance.loadBannerAD()
            }
        case "信息流广告1（图片）":
            if TopADManager.shareInstance.nativeIsReady() {
                // 跳转到测试页面
                let test = NativeAdViewController.init()
                self.navigationController?.pushViewController(test, animated: true)
                test.showNativeAD()
            }else{
                MBProgressHUD.xy_show("信息流广告1（图片）未加载完成")
                TopADManager.shareInstance.loadNativeAD()
            }
        case "信息流广告2":
            if TopADManager.shareInstance.nativeIsReady(nativeID: NATIVEADKEY2)
            {
                // 跳转到测试页面
                let test = NativeAdViewController.init()
                self.navigationController?.pushViewController(test, animated: true)
                test.showNativeAD(nativeID: NATIVEADKEY2)
            }else{
                MBProgressHUD.xy_show("信息流广告2未加载完成")
                TopADManager.shareInstance.loadNativeAD()
            }
            break
        case "激励视频":
            if TopADManager.shareInstance.rewardVideoAdIsReady() {
                TopADManager.shareInstance.showRewardVideoAD()
            }else{
                MBProgressHUD.xy_show("激励视频未加载完成")
                TopADManager.shareInstance.loadRewardVideoAD()
            }
        default:
            break
        }
    }
}
