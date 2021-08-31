//
//  MainItem.swift
//  RxSidedish
//
//  Created by Issac on 2021/08/31.
//

import Foundation

struct MainItem: Codable {
    let detailHash: String
    let imageURL: String
    let alt: String
    var deliveryType: [String] = [String]()
    let title: String
    let itemDescription: String
    var nPrice: String = ""
    let sPrice: String
    var badge: [String] = [String]()
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.detailHash = try container.decode(String.self, forKey: .detailHash)
        self.imageURL = try container.decode(String.self, forKey: .imageURL)
        self.alt = try container.decode(String.self, forKey: .alt)
        self.deliveryType = try container.decodeIfPresent([String].self, forKey: .deliveryType) ?? [String]()
        self.title = try container.decode(String.self, forKey: .title)
        self.itemDescription = try container.decode(String.self, forKey: .itemDescription)
        self.nPrice = try container.decodeIfPresent(String.self, forKey: .nPrice) ?? ""
        self.sPrice = try container.decode(String.self, forKey: .sPrice)
        self.badge = try container.decodeIfPresent([String].self, forKey: .badge) ?? [String]()
    }
    
    enum CodingKeys: String, CodingKey {
        case alt, title, badge
        case detailHash = "detail_hash"
        case imageURL = "image"
        case deliveryType = "delivery_type"
        case itemDescription = "description"
        case nPrice = "n_price"
        case sPrice = "s_price"
    }
}
