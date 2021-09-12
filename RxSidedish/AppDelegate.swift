//
//  AppDelegate.swift
//  RxSidedish
//
//  Created by Issac on 2021/08/30.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let sceneCoordinator = SceneCoordinator(window: window!)
        let networkUseCase = NetworkUseCase()
        let mainViewModel = MainViewModel(title: "", sceneCoordinator: sceneCoordinator, networkUseCase: networkUseCase)
        
        let mainScene = Scene.main(mainViewModel)
        
        sceneCoordinator.transition(to: mainScene, using: .root, animated: false)
        
        return true
    }
}

