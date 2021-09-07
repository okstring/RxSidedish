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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func configureTableView() {
        mainTableView.register(MainTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: MainTableViewHeaderView.className)
    }
    
    func bindViewModel() {
        Observable.zip(mainTableView.rx.modelSelected(SidedishItem.self), mainTableView.rx.itemSelected)
            .do(onNext: { [unowned self] (_, indexPath) in
                self.mainTableView.deselectRow(at: indexPath, animated: true)
            })
            .map{ $0.0 }
            .bind(to: viewModel.detailAction.inputs)
            .disposed(by: rx.disposeBag)
        
        viewModel.getSidedishes()
            .subscribe{ _ in }
            .disposed(by: rx.disposeBag)
        
        mainTableView.rx.setDelegate(delegate)
            .disposed(by: rx.disposeBag)
        
        viewModel.mainSections
            .bind(to: mainTableView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: rx.disposeBag)
    }
}
