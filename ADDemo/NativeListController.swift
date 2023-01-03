//
//  NativeListController.swift
//  ADDemo
//
//  Created by jingjun on 2023/1/3.
//

import UIKit
import AnyThinkNative

class NativeListController: UIViewController {
    
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
        tableview.register(NativeADTableCell.self, forCellReuseIdentifier: "NativeADTableCell")
        return tableview
    }()

    var dataSources: [ATDemoOfferAdMode] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        if TopADManager.shareInstance.nativeIsReady() {
            setData()
        }else{
            self.loadNativeAD()
        }
        
        TopADManager.shareInstance.adDidLoadFinishCallBack = { adID in
            if adID == NATIVEADKEY {
                self.setData()
            }
        }
    }
    
    func loadNativeAD() {
        TopADManager.shareInstance.loadNativeAD()
    }
    
    func setData() {
        if let offer = self.getOfferAndLoadNext() {
            var offerModel = ATDemoOfferAdMode.init()
            let config = TopADManager.shareInstance.getNativeConfig()
            offerModel.nativeADView = TopADManager.shareInstance.getNativeADView(config: config, offer: offer)
            offerModel.offer = offer
            offerModel.isNativeAd = true
            self.dataSources.append(offerModel)
        }
        for _ in 0..<5 {
            var offerModel = ATDemoOfferAdMode.init()
            offerModel.isNativeAd = false
            self.dataSources.append(offerModel)
        }
        self.tableView.reloadData()
    }

    func getOfferAndLoadNext() -> ATNativeAdOffer? {
        let offer = ATAdManager.shared().getNativeAdOffer(withPlacementID: NATIVEADKEY)
        return offer
    }
}

extension NativeListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.dataSources[indexPath.row]
        if model.isNativeAd {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NativeADTableCell", for: indexPath) as! NativeADTableCell
            cell.setADView(model.nativeADView)
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = self.dataSources[indexPath.row]
        if model.isNativeAd {
            return TopADManager.shareInstance.nativeHeight
        }else{
            return 300
        }
    }
}
