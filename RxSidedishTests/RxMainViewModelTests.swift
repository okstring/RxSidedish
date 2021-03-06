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
    
    var disposeBag: DisposeBag!
    override func setUp() {
        disposeBag = DisposeBag()
        
        let VC = UIViewController()
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = VC
        
        sceneCoordinator = SceneCoordinator(window: window)
        sidedishUseCase = SidedishUseCase()
        
        viewModel = MainViewModel(title: "",
                                  sceneCoordinator: sceneCoordinator,
                                  sidedishUseCase: sidedishUseCase)
        super.setUp()
    }
    
    func test_SidedishesFetch() {
        viewModel.fetchItems.onNext(())

        let fetched = try! viewModel.mainSections.toBlocking(timeout: 5).first()!
        
        XCTAssertEqual(fetched.count == 3, true)
        XCTAssertEqual(fetched.flatMap({ $0.items }).count > 0, true)
        ImageLoader.load(from: fetched[0].items[0].imageURL)
            .drive(onNext: { image in
                XCTAssertNotNil(image)
            }).disposed(by: disposeBag)
    }
}
