//
//  HomeListADCell.swift
//  LoveCat
//
//  Created by jingjun on 2022/5/26.
//

import UIKit
import BasicProject
import SnapKit
import AVFoundation
class HomeListADCell: UITableViewCell {
    
//    lazy var adView : ShowADView = {
//        let backview = ShowADView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_WIDTH * 150 / 228))
//        backview.backgroundColor = .white
//        return backview
//    }()
    lazy var adView: UIView = {
        return UIView()
    }()
    
    var nativeADChanged: ((Int) -> Void)?
    var heightConstraint: Constraint?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(adView)
        adView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.bottom.equalToSuperview()
            self.heightConstraint = make.height.equalTo(SCREEN_WIDTH * 150 / 228).constraint
        }
        
//        adView.loadADFinish = { result in
//            if result == 1 {
//                let height = self.adView.adView.frame.size.height
//                self.adView.isHidden = false
//                self.adView.adView.mediaView?.frame = CGRect(x: 0, y: 0, width: self.adView.adView.frame.size.width, height: height)
//                self.heightConstraint?.update(offset: height)
//            }else{
//                self.adView.isHidden = true
//                self.heightConstraint?.update(offset: 1)
//            }
//            self.nativeADChanged?(result)
//        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
