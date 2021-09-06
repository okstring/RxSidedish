//
//  MainViewModel.swift
//  RxSidedish
//
//  Created by Issac on 2021/08/31.
//

import Foundation
import RxSwift
import RxCocoa
import Action
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
    
    //viewController와 연결해야함
    func getSidedishes() {
        _ = Observable
            .zip(
                ServerAPI.mainCategories.map {
                    networkManager.get(type: MainBody.self, endpoint: $0)
            })
            .map({ $0.map{ $0.mainItems } })
            .subscribe(onNext: { [weak self] in
                self?.storage.allUpdateSidedish(newSidedishes: $0)
            })
    }
}
