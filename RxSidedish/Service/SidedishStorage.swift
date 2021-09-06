//
//  SidedishStorage.swift
//  RxSidedish
//
//  Created by Issac on 2021/09/01.
//

import Foundation
import RxSwift
import RxCocoa

class SidedishStorage: SidedishStorageType {
    
    private var sidedishes = [[SidedishItem.EMPTY(dummyID: "A")],
                              [SidedishItem.EMPTY(dummyID: "B")],
                              [SidedishItem.EMPTY(dummyID: "C")]]
    
    private var currentSidedish = SidedishItem.EMPTY
    
    private var sections: [MainSection] {
        return [
            MainSection(header: "안녕하세요 첫번째 섹션", items: sidedishes[0]),
            MainSection(header: "안녕하세요 두번째 섹션", items: sidedishes[1]),
            MainSection(header: "안녕하세요 알쥬?", items: sidedishes[2])
        ]
    }
    
    private lazy var subject = BehaviorRelay<[MainSection]>(value: sections)
    
    func sidedishesList() -> Observable<[MainSection]> {
        return subject.asObservable()
    }
    
    func allUpdateSidedish(newSidedishes: [[SidedishItem]]) -> Observable<([[SidedishItem]])> {
        sidedishes = newSidedishes
        
        subject.accept(sections)
        
        return Observable.just(sidedishes)
    }
}
