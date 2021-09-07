//
//  DetailBody.swift
//  RxSidedish
//
//  Created by Issac on 2021/08/31.
//

import Foundation

struct DetailSidedishItem: Decodable, Equatable {
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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let bodyContainer = try container.nestedContainer(keyedBy: BodyCodingKeys.self, forKey: .data)
        self.topImageURL = try bodyContainer.decode(String.self, forKey: .topImageURL)
        self.subTopImages = try bodyContainer.decode([String].self, forKey: .subTopImagesURL)
        self.productDescription = try bodyContainer.decode(String.self, forKey: .productDescription)
        self.point = try bodyContainer.decode(String.self, forKey: .point)
        self.deliveryInfo = try bodyContainer.decode(String.self, forKey: .deliveryInfo)
        self.deliveryFee = try bodyContainer.decode(String.self, forKey: .deliveryFee)
        self.prices = try bodyContainer.decode([String].self, forKey: .prices)
        self.detailSectionImagesURL = try bodyContainer.decode([String].self, forKey: .detailSectionImagesURL)
    }
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    enum BodyCodingKeys: String, CodingKey {
        case point, prices
        case topImageURL = "top_image"
        case subTopImagesURL = "thumb_images"
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
