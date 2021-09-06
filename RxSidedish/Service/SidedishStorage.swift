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
    
    private var currentSidedish = SidedishItem.EMPTY(dummyID: "Z")
    
    private var sections: [MainSection] {
        return [
            MainSection(header: "모두가 좋아하는 든든한 메인요리", category: "메인요리", items: sidedishes[0]),
            MainSection(header: "정성이 담긴 뜨끈뜨끈 국물요리", category: "국물요리", items: sidedishes[1]),
            MainSection(header: "식탁을 풍성하게 하는 정갈한 밑반찬", category: "밑반찬", items: sidedishes[2])
        ]
    }
    
    private lazy var subject = BehaviorRelay<[MainSection]>(value: sections)
    
    func sidedishesList() -> Observable<[MainSection]> {
        return subject.asObservable()
    }
    
    func allUpdateSidedish(_ newSidedishes: [[SidedishItem]]) -> Observable<[MainSection]> {
        sidedishes = newSidedishes
        
        subject.accept(sections)
        
        return Observable.just(sections)
    }
}
