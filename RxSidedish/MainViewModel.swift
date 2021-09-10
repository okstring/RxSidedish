//
//  MainViewModel.swift
//  RxSidedish
//
//  Created by Issac on 2021/08/31.
//

import Foundation
import RxSwift
import RxDataSources
import Action

struct MainSection {
    var header: String
    var category: String
    var items: [SidedishItem]
}

extension MainSection: AnimatableSectionModelType {
    var identity: String {
        return header
    }
    
    init(original: MainSection, items: [SidedishItem]) {
        self = original
        self.items = items
    }
}

class MainViewModel: CommonViewModel {
    let disposeBag = DisposeBag()
    
    let dataSource: RxTableViewSectionedAnimatedDataSource<MainSection> = {
        let ds = RxTableViewSectionedAnimatedDataSource<MainSection> { (dataSource, tableView, indexPath, sidedishItem) -> UITableViewCell in
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.className) as? MainTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(item: sidedishItem)
            return cell
        }
        
        return ds
    }()
    
    var mainSections: Observable<[MainSection]> {
        return storage.sidedishesList()
    }
    
    lazy var detailAction: Action<SidedishItem, Void> = {
        return Action { item in
            
            let detailViewModel = DetailViewModel(title: item.title, sceneCoordinator: self.sceneCoordinator, storage: self.storage, networkUseCase: self.networkUseCase, detailHash: item.detailHash)
            
            let detailScene = Scene.detail(detailViewModel)
            
            return self.sceneCoordinator.transition(to: detailScene, using: .push, animated: true).asObservable().map{ _ in }
        }
    }()
    
    let fetchItems: AnyObserver<Void>
    
    override init(title: String, sceneCoordinator: SceneCoordinatorType, storage: SidedishStorageType, networkUseCase: NetworkUseCase) {
        
        let fetching = PublishSubject<Void>()
        
        let items = PublishSubject<[MainSection]>()
        
        fetchItems = fetching.asObserver()
        
        fetching
            .asObservable()
            .flatMap({ networkUseCase.getSidedishItems() })
            .flatMap( storage.allUpdateSidedish )
            .subscribe(onNext: items.onNext)
            .disposed(by: disposeBag)
        
        super.init(title: title, sceneCoordinator: sceneCoordinator, storage: storage, networkUseCase: networkUseCase)
    }
}
