//
//  ViewController.swift
//  RxSidedish
//
//  Created by Issac on 2021/08/30.
//

import UIKit
import NSObject_Rx
import RxSwift
import RxCocoa

class MainViewController: UIViewController, ViewModelBindableType {
    @IBOutlet weak var mainTableView: UITableView!
    var viewModel: MainViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getSidedishes()
    }
    
    func bindViewModel() {
        mainTableView.rx.setDelegate(self)
            .disposed(by: rx.disposeBag)
        
        viewModel.memoList
            .bind(to: mainTableView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: rx.disposeBag)
    }
}

extension MainViewController: UITableViewDelegate {
    
}
