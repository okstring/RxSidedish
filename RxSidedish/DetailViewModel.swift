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
    var thumbnailImagesURL: Observable<[String]>
    var detailImagesURL: Observable<[String]>
    var detailSidedishItem: Observable<DetailSidedishItem>
    
    init(title: String, sceneCoordinator: SceneCoordinatorType, storage: SidedishStorageType, networkManager: Networkable, detailHash: String) {
        
        let fetching = PublishSubject<Void>()
        let item = BehaviorSubject<DetailSidedishItem>(value: DetailSidedishItem.EMPTY)
        
        fetchItem = fetching.asObserver()
        
        fetching
            .asObservable()
            .flatMap{ networkManager.get(type: DetailBody.self, endpoint: .detail(detailHash)) }
            .map({ return $0.data })
            .subscribe(onNext: item.onNext)
            .disposed(by: disposeBag)
        
        thumbnailImagesURL = item.map({ $0.thumbnailImagesURL })
            .asObservable()
            
        detailImagesURL = item.map({ $0.detailSectionImagesURL })
            .asObservable()
        
        detailSidedishItem = item.asObservable()
        
        super.init(title: title, sceneCoordinator: sceneCoordinator, storage: storage, networkManager: networkManager)
    }
}
