//
//  RxMainViewModelTests.swift
//  RxSidedishTests
//
//  Created by Issac on 2021/09/10.
//

import XCTest
@testable import RxSidedish

import RxSwift
import RxBlocking

class RxMainViewModelTests: XCTestCase {
    
    var viewModel: MainViewModel!
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
        
        viewModel = MainViewModel(title: "",
                                  sceneCoordinator: sceneCoordinator,
                                  storage: storage,
                                  networkUseCase: networkUseCase)
    }
    
    func test_SidedishesFetch() {
        viewModel.fetchItems.onNext(())
        
        let fetched = try! viewModel.storage.sidedishesList().toBlocking().first()!
        
        XCTAssertEqual(fetched.count == 3, true)
    }
}
