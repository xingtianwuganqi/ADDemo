//
//  ATNativeListOfferAdMode.swift
//  ADDemo
//
//  Created by jingjun on 2023/1/3.
//

import Foundation
import AnyThinkNative

public struct ATNativeListOfferAdMode {
    public init() {}
    public var nativeADView: ATNativeADView?
    public var offer: ATNativeAdOffer?
    public var drawVideoUrlStr: String?
    public var isNativeAd: Bool = false
}
