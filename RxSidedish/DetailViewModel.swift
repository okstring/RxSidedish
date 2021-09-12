//
//  DetailViewModel.swift
//  RxSidedish
//
//  Created by Issac on 2021/08/31.
//

import Foundation
import RxSwift
import RxCocoa

final class DetailViewModel: CommonViewModel {
    private var disposeBag = DisposeBag()
    
    var fetchItem: AnyObserver<Void>
    var sidedishItem: Observable<(ViewDetailSidedishItem)>
    
    var thumbnailImagesURL: Observable<String>
    var detailSectionImageURL: Observable<String>
    
    init(title: String, sceneCoordinator: SceneCoordinatorType, sidedishUseCase: SidedishUseCase, detailHash: String) {
        
        let fetching = PublishSubject<Void>()
        
        let item = PublishSubject<ViewDetailSidedishItem>()
        
        fetchItem = fetching.asObserver()
        
        fetching
            .asObservable()
            .flatMap{ sidedishUseCase.getDetailSideDishItem(hash: detailHash) }
            .map({ ViewDetailSidedishItem(title: title, item: $0) })
            .subscribe(onNext: item.onNext)
            .disposed(by: disposeBag)
        
        sidedishItem = item.asObservable()
        
        thumbnailImagesURL = sidedishItem
            .map({ $0.thumbnailImagesURL })
            .flatMap({ Observable.from($0) })
        
        detailSectionImageURL = sidedishItem
            .map({ $0.detailSectionImagesURL })
            .flatMap({ Observable.from($0) })
        
        super.init(title: title, sceneCoordinator: sceneCoordinator, sidedishUseCase: sidedishUseCase)
    }
}
