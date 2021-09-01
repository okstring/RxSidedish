//
//  MainBody.swift
//  RxSidedish
//
//  Created by Issac on 2021/08/31.
//

import Foundation

struct MainBody: Codable {
    let mainItems: [SidedishItem]
    
    enum CodingKeys: String, CodingKey {
        case mainItems = "body"
    }
}
