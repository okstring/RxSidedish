//
//  SidedishStorageType.swift
//  RxSidedish
//
//  Created by Issac on 2021/09/01.
//

import Foundation
import RxSwift

protocol SidedishStorageType {
    @discardableResult
    func allUpdateSidedish(newSidedishes: [[SidedishItem]]) -> Observable<([[SidedishItem]])>
    
    @discardableResult
    func sidedishesList() -> Observable<[MainSection]>
}
