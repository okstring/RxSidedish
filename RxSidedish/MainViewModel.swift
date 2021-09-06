//
//  MainViewModel.swift
//  RxSidedish
//
//  Created by Issac on 2021/08/31.
//

import Foundation
import RxSwift
import RxDataSources

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
    
    
    func getSidedishes() -> Observable<[MainSection]> {
        Observable.zip(
            ServerAPI.mainCategories.map {
                networkManager.get(type: MainBody.self, endpoint: $0)
            })
            .map({ $0.map{ $0.mainItems } })
            .flatMap(storage.allUpdateSidedish)
            .asObservable()
    }
}
