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
    let sidedishUseCase: SidedishUseCase
    
    init(title: String, sceneCoordinator: SceneCoordinatorType, sidedishUseCase: SidedishUseCase) {
        self.title = Observable.just(title).asDriver(onErrorJustReturn: "")
        self.sceneCoordinator = sceneCoordinator
        self.sidedishUseCase = sidedishUseCase
    }
}
