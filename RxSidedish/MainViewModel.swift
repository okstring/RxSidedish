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

final class MainViewModel: CommonViewModel {
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
    
    lazy var detailAction: Action<SidedishItem, Void> = {
        return Action { item in
            
            let detailViewModel = DetailViewModel(title: item.title, sceneCoordinator: self.sceneCoordinator, sidedishUseCase: self.sidedishUseCase, detailHash: item.detailHash)
            
            let detailScene = Scene.detail(detailViewModel)
            
            return self.sceneCoordinator.transition(to: detailScene, using: .push, animated: true).asObservable().map{ _ in }
        }
    }()
    
    let fetchItems: AnyObserver<Void>
    var mainSections: Observable<[MainSection]>
    
    override init(title: String, sceneCoordinator: SceneCoordinatorType, sidedishUseCase: SidedishUseCase) {
        
        let fetching = PublishSubject<Void>()
        
        let items = PublishSubject<[MainSection]>()
        
        fetchItems = fetching.asObserver()
        
        fetching
            .asObservable()
            .flatMap({ sidedishUseCase.getSidedishItems() })
            .flatMap({ sidedishUseCase.makeMainSection(sidedishItems: $0) })
            .subscribe(onNext: items.onNext)
            .disposed(by: disposeBag)
        
        mainSections = items.asObservable()
        
        super.init(title: title, sceneCoordinator: sceneCoordinator, sidedishUseCase: sidedishUseCase)
    }
}
