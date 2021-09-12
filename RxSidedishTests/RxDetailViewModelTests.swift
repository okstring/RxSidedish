//
//  RxDetailViewModelTests.swift
//  RxSidedishTests
//
//  Created by Issac on 2021/09/10.
//

import XCTest
@testable import RxSidedish

import RxSwift
import RxBlocking


class RxDetailViewModelTests: XCTestCase {
    
    var viewModel: DetailViewModel!
    var sceneCoordinator: SceneCoordinatorType!
    var storage: SidedishStorage!
    var networkUseCase: SidedishUseCase!
    
    override func setUp() {
        
        let VC = UIViewController()
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = VC
        
        sceneCoordinator = SceneCoordinator(window: window)
        storage = SidedishStorage()
        networkUseCase = SidedishUseCase()
        
        viewModel = DetailViewModel(title: "test",
                                    sceneCoordinator: sceneCoordinator,
                                    storage: storage,
                                    networkUseCase: networkUseCase,
                                    detailHash: "H26C7")
    }
    
    func test_detailFetch() {
        viewModel.fetchItem.onNext(())
        
        let fetched = try! viewModel.sidedishItem.toBlocking().first()!
        
        XCTAssertEqual(fetched.title == "test", true)
    }
}
