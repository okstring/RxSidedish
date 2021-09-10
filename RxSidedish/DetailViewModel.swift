//
//  DetailViewModel.swift
//  RxSidedish
//
//  Created by Issac on 2021/08/31.
//

import Foundation
import RxSwift
import RxCocoa

class DetailViewModel: CommonViewModel {
    var disposeBag = DisposeBag()
    
    var fetchItem: AnyObserver<Void>
    var item: Observable<(ViewDetailSidedishItem)>
    
    init(title: String, sceneCoordinator: SceneCoordinatorType, storage: SidedishStorageType, networkManager: Networkable, detailHash: String) {
        
        let fetching = PublishSubject<Void>()
        
        fetchItem = fetching.asObserver()
        
        item = fetching
            .asObservable()
            .debug()
            .flatMap{ networkManager.get(type: DetailBody.self, endpoint: .detail(detailHash)) }
            .map({ ViewDetailSidedishItem(title: title, item: $0.data) })
        
        super.init(title: title, sceneCoordinator: sceneCoordinator, storage: storage, networkManager: networkManager)
    }
}
