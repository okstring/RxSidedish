//
//  DetailViewController.swift
//  RxSidedish
//
//  Created by Issac on 2021/08/31.
//

import UIKit
import RxCocoa
import RxSwift

class DetailViewController: UIViewController, ViewModelBindableType {
    var viewModel: DetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func bindViewModel() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
    }
}
