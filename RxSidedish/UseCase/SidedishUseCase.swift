//
//  NetworkUseCase.swift
//  RxSidedish
//
//  Created by Issac on 2021/09/10.
//

import Foundation
import RxSwift

final class SidedishUseCase {
    let networkManager: Networkable
    
    init(networkManager: Networkable = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func getSidedishItems() -> Observable<[[SidedishItem]]> {
        return Observable.zip(
            ServerAPI.mainCategories.map {
                networkManager.get(type: MainBody.self, endpoint: $0)
            })
            .map({ $0.map{ $0.mainItems } })
    }
    
    func makeMainSection(sidedishItems: [[SidedishItem]]) -> Observable<[MainSection]> {
        return Observable.zip(Observable.just(Category.allCases), Observable.just(sidedishItems))
            .flatMap { (items) -> Observable<[MainSection]> in
                let (categories, sidedishitems) = items
                let mainSections = (0..<categories.count).map({ index in
                    MainSection(header: categories[index].header, category: categories[index].categoryName, items: sidedishitems[index])
                })
                return Observable.just(mainSections)
            }
        
    }
    
    func getDetailSideDishItem(hash: String) -> Observable<DetailSidedishItem> {
        return networkManager.get(type: DetailBody.self, endpoint: .detail(hash))
            .map({ $0.data })
    }
}
