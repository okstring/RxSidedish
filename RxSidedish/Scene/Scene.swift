//
//  Scene.swift
//  RxSidedish
//
//  Created by Issac on 2021/08/31.
//

import UIKit

enum Scene {
    case main(MainViewModel)
    case detail(DetailViewModel)
}

extension Scene {
    func instantiate(from storyboard: String = "Main") -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        
        switch self {
        case .main(let viewModel):
            guard let nav = storyboard.instantiateViewController(identifier: "MainNav") as? UINavigationController else {
                fatalError()
            }
            
            guard var mainVC = nav.viewControllers.first as? MainViewController else {
                fatalError()
            }
            
            mainVC.bind(viewModel: viewModel)
            return nav
        case .detail(let viewModel):
            var detailVC = DetailViewController()
            detailVC.bind(viewModel: viewModel)
            return detailVC
        }
    }
}
