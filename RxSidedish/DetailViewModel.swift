//
//  DetailViewModel.swift
//  RxSidedish
//
//  Created by Issac on 2021/08/31.
//

import Foundation
import RxSwift

class DetailViewModel: CommonViewModel {
    var disposeBag = DisposeBag()
    
    var fetchItem: AnyObserver<Void>

    
    init(title: String, sceneCoordinator: SceneCoordinatorType, storage: SidedishStorageType, networkManager: Networkable, detailHash: String) {
        let fetching = PublishSubject<Void>()
        let item = BehaviorSubject<DetailSidedishItem>(value: DetailSidedishItem.EMPTY)
        
        fetchItem = fetching.asObserver()
        
        fetching
            .asObservable()
            .flatMap{ networkManager.get(type: DetailBody.self, endpoint: .detail(detailHash)) }
            .map({ $0.data })
            .subscribe(onNext: { item.onNext($0) })
            .disposed(by: disposeBag)

        
        super.init(title: title, sceneCoordinator: sceneCoordinator, storage: storage, networkManager: networkManager)
    }
}
