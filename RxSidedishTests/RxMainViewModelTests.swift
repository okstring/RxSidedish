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
    var sidedishUseCase: SidedishUseCase!
    
    override func setUp() {
        
        let VC = UIViewController()
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = VC
        
        sceneCoordinator = SceneCoordinator(window: window)
        sidedishUseCase = SidedishUseCase()
        
        viewModel = MainViewModel(title: "",
                                  sceneCoordinator: sceneCoordinator,
                                  sidedishUseCase: sidedishUseCase)
    }
    
    func test_SidedishesFetch() {
        viewModel.fetchItems.onNext(())

        let fetched = try! viewModel.mainSections.toBlocking().first()!
        
        XCTAssertEqual(fetched.count == 3, true)
        XCTAssertEqual(fetched.flatMap({ $0.items }).count > 0, true)
    }
}
