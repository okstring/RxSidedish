//
//  DetailBody.swift
//  RxSidedish
//
//  Created by Issac on 2021/08/31.
//

import Foundation

struct DetailSidedishItem: Codable {
    let topImageURL: String
    let subTopImages: [String]
    var thumbnailImagesURL: [String] {
        return [topImageURL] + subTopImages
    }
    let productDescription: String
    let point: String
    let deliveryInfo: String
    let deliveryFee: String
    let prices: [String]
    var price: String? {
        return prices.last
    }
    let detailSectionImagesURL: [String]
    
    enum CodingKeys: String, CodingKey {
        case point, prices
        case topImageURL = "top_image"
        case subTopImages = "thumb_images"
        case productDescription = "product_description"
        case deliveryInfo = "delivery_info"
        case deliveryFee = "delivery_fee"
        case detailSectionImagesURL = "detail_section"
    }
    
    init(topImageURL: String, subTopImages: [String], productDescription: String, point: String, deliveryInfo: String, deliveryFee: String, prices: [String], detailSectionImagesURL: [String]) {
        self.topImageURL = topImageURL
        self.subTopImages = subTopImages
        self.productDescription = productDescription
        self.point = point
        self.deliveryInfo = deliveryInfo
        self.deliveryFee = deliveryFee
        self.prices = prices
        self.detailSectionImagesURL = detailSectionImagesURL
    }
}

extension DetailSidedishItem {
    static var EMPTY: DetailSidedishItem {
        return DetailSidedishItem(topImageURL: "", subTopImages: [String](), productDescription: "", point: "", deliveryInfo: "", deliveryFee: "", prices: [String](), detailSectionImagesURL: [String]())
    }
}
