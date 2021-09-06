//
//  SidedishStorageType.swift
//  RxSidedish
//
//  Created by Issac on 2021/09/01.
//

import Foundation
import RxSwift

enum SidedishCategory {
    case main(title: String, sidedishes: [SidedishItem])
    case soup(title: String, sidedishes: [SidedishItem])
    case side(title: String, sidedishes: [SidedishItem])
    
    var index: Int {
        switch self {
        case .main: return 0
        case .soup: return 1
        case .side: return 2
        }
    }
}

protocol SidedishStorageType {
    @discardableResult
    func allUpdateSidedish(newSidedishes: [[SidedishItem]]) -> Observable<([[SidedishItem]])>
    
    @discardableResult
    func sidedishesList() -> Observable<[[SidedishItem]]>
}
