//
//  MainCategory.swift
//  RxSidedish
//
//  Created by Issac on 2021/09/12.
//

import Foundation


enum Category: CaseIterable {
    case main
    case soup
    case side
    
    var header: String {
        switch self {
        case .main: return "모두가 좋아하는 든든한 메인요리"
        case .soup: return "정성이 담긴 뜨끈뜨끈 국물요리"
        case .side: return "식탁을 풍성하게 하는 정갈한 밑반찬"
        }
    }
    
    var categoryName: String {
        switch self {
        case .main: return "메인요리"
        case .soup: return "국물요리"
        case .side: return "밑반찬"
        }
    }
}
