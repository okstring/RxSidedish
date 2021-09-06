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
        mainTableView.rx.setDelegate(self)
            .disposed(by: rx.disposeBag)
        
        viewModel.mainSections
            .bind(to: mainTableView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: rx.disposeBag)
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: MainTableViewHeaderView.className) as? MainTableViewHeaderView else { return UIView() }
        view.configure(sectionModel: viewModel.dataSource.sectionModels[section])
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}
