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
import RxViewController

final class MainViewController: UIViewController, ViewModelBindableType {
    @IBOutlet weak var mainTableView: UITableView!
    
    var viewModel: MainViewModel!
    
    lazy private var delegate = MainTableViewDelegate(viewModel: viewModel)
    
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
        
        rx.viewWillAppear
            .take(1)
            .map({ _ in })
            .bind(to: viewModel.fetchItems)
            .disposed(by: rx.disposeBag)
        
        Observable.zip(mainTableView.rx.modelSelected(SidedishItem.self), mainTableView.rx.itemSelected)
            .do(onNext: { [unowned self] (_, indexPath) in
                self.mainTableView.deselectRow(at: indexPath, animated: true)
            })
            .map{ $0.0 }
            .bind(to: viewModel.detailAction.inputs)
            .disposed(by: rx.disposeBag)
        
        
        mainTableView.rx
            .setDelegate(delegate)
            .disposed(by: rx.disposeBag)
        
        viewModel.mainSections
            .bind(to: mainTableView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: rx.disposeBag)
    }
}
