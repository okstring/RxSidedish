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
    
    func allUpdateSidedish(of category: SidedishCategory, newSidedishes: [SidedishItem]) -> Observable<([SidedishItem], SidedishCategory)> {
        sidedishes[category.index] = newSidedishes
        
        store.onNext(sidedishes)
        
        return Observable.just((newSidedishes, category))
    }
}
