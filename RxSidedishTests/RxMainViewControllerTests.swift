//
//  RxMainViewControllerTests.swift
//  RxSidedishTests
//
//  Created by Issac on 2021/09/13.
//

import XCTest
@testable import RxSidedish
import RxSwift
import RxBlocking

class RxMainViewControllerTests: XCTestCase {
    var window: UIWindow!
    var sceneCoordinator: SceneCoordinatorType!
    var viewController: MainViewController!
    var viewModel: MainViewModel!
    var useCase: SidedishUseCase!
    var networkManager: Networkable!
    var sessionManager: SessionManagerProtocol!
    var delegate: MainTableViewDelegate!
    var disposeBag: DisposeBag!
    var mainScene: Scene!
        
    override func setUp() {
        disposeBag = DisposeBag()
        
        window = UIWindow()
        window.rootViewController = UIViewController()
        
        sceneCoordinator = SceneCoordinator(window: window)
        networkManager = NetworkManager()
        useCase = SidedishUseCase(networkManager: networkManager)
        viewModel = MainViewModel(title: "", sceneCoordinator: sceneCoordinator, sidedishUseCase: useCase)
        delegate = MainTableViewDelegate(viewModel: viewModel)
        mainScene = Scene.main(viewModel)
        
        sceneCoordinator.transition(to: mainScene, using: .root, animated: false)
            .subscribe(onCompleted: {
                self.viewController = self.window.rootViewController?.children.first as? MainViewController
            }).disposed(by: disposeBag)
        super.setUp()
    }
    
    func test_configureImageInMainTableViewCell() {
        viewModel.fetchItems.onNext(())
        
    }

}
