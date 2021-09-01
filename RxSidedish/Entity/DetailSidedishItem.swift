//
//  DetailBody.swift
//  RxSidedish
//
//  Created by Issac on 2021/08/31.
//

import Foundation

struct DetailSidedishItem: Decodable {
    let topImageURL: String
    let thumbImagesURL: [String]
    let productDescription: String
    let point: String
    let deliveryInfo: String
    let deliveryFee: String
    let prices: [String]
    let detailSectionImagesURL: [String]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let bodyContainer = try container.nestedContainer(keyedBy: BodyCodingKeys.self, forKey: .data)
        self.topImageURL = try bodyContainer.decode(String.self, forKey: .topImageURL)
        self.thumbImagesURL = try bodyContainer.decode([String].self, forKey: .thumbImagesURL)
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
        case thumbImagesURL = "thumb_images"
        case productDescription = "product_description"
        case deliveryInfo = "delivery_info"
        case deliveryFee = "delivery_fee"
        case detailSectionImagesURL = "detail_section"
    }
}
