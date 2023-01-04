//
//  NativeADTableCell.swift
//  ADDemo
//
//  Created by jingjun on 2023/1/3.
//

import UIKit
import AnyThinkNative

public class NativeADTableCell: UITableViewCell {
    
    public var adView: ATNativeADView?
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .white
    }
    
    public func setADView(_ adview: ATNativeADView?) {
        guard let adview = adview else {
            return
        }
        if self.adView == adview {
            return
        }
        self.adView?.removeFromSuperview()
        self.adView = nil
        self.contentView.addSubview(adview)
        adview.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
            make.height.equalTo(TopADManager.shareInstance.nativeHeight)
        }
        self.adView = adview
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
