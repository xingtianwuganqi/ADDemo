//
//  DMADView.swift
//  LoveCat
//
//  Created by jingjun on 2022/5/25.
//

import UIKit
import AnyThinkNative
import BasicProject
import SDWebImage

class ATNativeSelfRenderView: UIView {
    
    var advertiserLabel: UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .left
        label.isUserInteractionEnabled = true
        return label
    }()
    
    var titleLabel : UILabel  = {
        let label = UILabel.init()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        label.isUserInteractionEnabled = true
        return label
    }()

    
    lazy var textLabel: UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        label.isUserInteractionEnabled = true
        return label
    }()
        
    var ctaLabel : UILabel  = {
        let label = UILabel.init()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        label.isUserInteractionEnabled = true
        return label
    }()
    
    var ratingLabel : UILabel  = {
        let label = UILabel.init()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        label.isUserInteractionEnabled = true
        return label
    }()
    
    var domainLabel : UILabel  = {
        let label = UILabel.init()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        label.isUserInteractionEnabled = true
        return label
    }()
    
    var warningLabel : UILabel  = {
        let label = UILabel.init()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        label.isUserInteractionEnabled = true
        return label
    }()
    
    var iconImageView : UIImageView  = {
        let imgView = UIImageView.init()
        imgView.layer.masksToBounds = true
        imgView.layer.cornerRadius = 4
        imgView.contentMode = .scaleAspectFit
        imgView.isUserInteractionEnabled = true
        return imgView
    }()
    
    var mainImageView: UIImageView = {
        let imgView = UIImageView.init()
        imgView.contentMode = .scaleAspectFit
        imgView.isUserInteractionEnabled = true
        return imgView
    }()
    
    var logoImageView: UIImageView = {
        let imgView = UIImageView.init()
        imgView.contentMode = .scaleAspectFit
        imgView.isUserInteractionEnabled = true
        return imgView
    }()
    
    var dislikeButton: UIButton = {
        let button = UIButton.init(type: .custom)
        return button
    }()
    
    var mediaView: UIView = {
        let backview = UIView()
        return backview
    }()
    
    var offer: ATNativeAdOffer
    
    init(offer: ATNativeAdOffer) {
        self.offer = offer
        super.init(frame: .zero)
        addViews()
        setupUI()
    }
    
    func addViews() {
        addSubview(advertiserLabel)
        addSubview(titleLabel)
        addSubview(textLabel)
        addSubview(ctaLabel)
        addSubview(ratingLabel)
        addSubview(iconImageView)
        addSubview(domainLabel)
        addSubview(warningLabel)
        addSubview(iconImageView)
        addSubview(mainImageView)
        addSubview(logoImageView)
        addSubview(dislikeButton)
        
        self.logoImageView.snp.makeConstraints { make in
            make.height.width.equalTo(25)
            make.left.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(5)
        }
        self.titleLabel.snp.makeConstraints { make in
            make.left.equalTo(logoImageView.snp.right).offset(10)
            make.right.equalToSuperview().offset(-15)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalTo(logoImageView.snp.right).offset(10)
            make.right.equalToSuperview().offset(-15)
        }
        
        self.ctaLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalTo(logoImageView.snp.right).offset(10)
            make.right.equalToSuperview().offset(-15)
        }
        
        self.advertiserLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalTo(ctaLabel)
        }
        
        self.ratingLabel.snp.makeConstraints { make in
            make.right.equalTo(advertiserLabel.snp.left).offset(-5)
            make.centerY.equalTo(ctaLabel)
        }
        
        self.iconImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 75, height: 75))
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(10)
        }
        
        self.mainImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(iconImageView.snp.bottom).offset(15)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
    
    func setupUI() {
        if let icon = self.offer.nativeAd.icon {
            self.iconImageView.image = icon
        }else{
            self.iconImageView.sd_setImage(with: URL(string: self.offer.nativeAd.iconUrl ?? ""))
        }
        if let mainImg = self.offer.nativeAd.mainImage {
            self.mainImageView.image = mainImg
        }else{
            self.mainImageView.sd_setImage(with: URL(string: self.offer.nativeAd.imageUrl ?? ""))
        }
        self.logoImageView.sd_setImage(with: URL(string: self.offer.nativeAd.logoUrl ?? ""))
        self.advertiserLabel.text = self.offer.nativeAd.advertiser
        self.titleLabel.text = self.offer.nativeAd.title
        self.textLabel.text = self.offer.nativeAd.mainText
        self.ctaLabel.text = self.offer.nativeAd.ctaText
        self.ratingLabel.text = "\(self.offer.nativeAd.rating ?? 0)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
