//
//  CommonViewModel.swift
//  RxSidedish
//
//  Created by Issac on 2021/09/02.
//

import Foundation
import RxSwift
import RxCocoa

class CommonViewModel: NSObject {
    let title: Driver<String>
    let sceneCoordinator: SceneCoordinatorType
    let storage: SidedishStorageType
    
    init(title: String, sceneCoordinator: SceneCoordinatorType, storage: SidedishStorageType) {
        self.title = Observable.just(title).asDriver(onErrorJustReturn: "")
        self.sceneCoordinator = sceneCoordinator
        self.storage = storage
    }
}
