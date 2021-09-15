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
    var sidedishUseCase: SidedishUseCase!
    
    override func setUp() {
        
        let VC = UIViewController()
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = VC
        
        sceneCoordinator = SceneCoordinator(window: window)
        sidedishUseCase = SidedishUseCase()
        
        viewModel = DetailViewModel(title: "test",
                                    sceneCoordinator: sceneCoordinator,
                                    sidedishUseCase: sidedishUseCase,
                                    detailHash: "H26C7")
        super.setUp()
    }
    
    func test_detailFetch() {
        viewModel.fetchItem.onNext(())
        
        let fetched = try! viewModel.sidedishItem.toBlocking(timeout: 5).first()!
        
        XCTAssertEqual(fetched.title == "test", true)
    }
}
