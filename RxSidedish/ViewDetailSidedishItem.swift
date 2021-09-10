//
//  ViewDetailSidedishItem.swift
//  RxSidedish
//
//  Created by Issac on 2021/09/10.
//

import Foundation

struct ViewDetailSidedishItem: Equatable {
    var title: String
    var thumbnailImagesURL: [String]
    let productDescription: String
    let point: String
    let deliveryInfo: String
    let deliveryFee: String
    var price: String?
    let detailSectionImagesURL: [String]
    
    init(title: String, thumbnailImagesURL: [String], productDescription: String, point: String, deliveryInfo: String, deliveryFee: String, price: String? = nil, detailSectionImagesURL: [String]) {
        self.title = title
        self.thumbnailImagesURL = thumbnailImagesURL
        self.productDescription = productDescription
        self.point = point
        self.deliveryInfo = deliveryInfo
        self.deliveryFee = deliveryFee
        self.price = price
        self.detailSectionImagesURL = detailSectionImagesURL
    }
    
    init(title: String, item: DetailSidedishItem) {
        self.title = title
        self.thumbnailImagesURL = item.thumbnailImagesURL
        self.productDescription = item.productDescription
        self.point = item.point
        self.deliveryInfo = item.deliveryInfo
        self.deliveryFee = item.deliveryFee
        self.price = item.price
        self.detailSectionImagesURL = item.detailSectionImagesURL
    }
}
