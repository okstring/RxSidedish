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
    
    lazy var delegate = MainTableViewDelegate(viewModel: viewModel)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
        viewModel.getSidedishes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    private func configureTableView() {
        mainTableView.register(MainTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: MainTableViewHeaderView.className)
    }
    
    func bindViewModel() {
        mainTableView.rx.setDelegate(delegate)
            .disposed(by: rx.disposeBag)
        
        viewModel.mainSections
            .bind(to: mainTableView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: rx.disposeBag)
    }
}
