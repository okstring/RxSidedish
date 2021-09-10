//
//  NetworkUseCase.swift
//  RxSidedish
//
//  Created by Issac on 2021/09/10.
//

import Foundation
import RxSwift

class NetworkUseCase {
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
    
    func getDetailSideDishItem(hash: String) -> Observable<DetailSidedishItem> {
        
        return networkManager.get(type: DetailBody.self, endpoint: .detail(hash))
            .map({ $0.data })
    }
}
