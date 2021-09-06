//
//  SidedishStorage.swift
//  RxSidedish
//
//  Created by Issac on 2021/09/01.
//

import Foundation
import RxSwift

class SidedishStorage: SidedishStorageType {
    
    private var sidedishes = [[SidedishItem]]()
    
    private var currentSidedish = SidedishItem.EMPTY
    
    private lazy var sections: [SidedishSectionModel] = [
        SidedishSectionModel(model: 0, items: sidedishes[0]),
        SidedishSectionModel(model: 1, items: sidedishes[1]),
        SidedishSectionModel(model: 2, items: sidedishes[2])
    ]
    
    private lazy var store = BehaviorSubject<[[SidedishItem]]>(value: sidedishes)
    
    func sidedishesList() -> Observable<[[SidedishItem]]> {
        return store
    }
    
    func allUpdateSidedish(newSidedishes: [[SidedishItem]]) -> Observable<([[SidedishItem]])> {
        sidedishes = newSidedishes
        
        store.onNext(sidedishes)
        
        return Observable.just(sidedishes)
    }
}
