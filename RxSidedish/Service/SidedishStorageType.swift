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
    func allUpdateSidedish(_ newSidedishes: [[SidedishItem]]) -> Observable<[MainSection]>
    
    @discardableResult
    func sidedishesList() -> Observable<[MainSection]>
}
