//
//  DetailViewController.swift
//  RxSidedish
//
//  Created by Issac on 2021/08/31.
//

import UIKit
import RxCocoa
import RxSwift
import RxViewController

class DetailViewController: UIViewController, ViewModelBindableType {
    var viewModel: DetailViewModel!
    
    @IBOutlet weak var thumbnailStackView: ThumbnailStackView!
    @IBOutlet weak var descriptionView: DescriptionView!
    @IBOutlet weak var detailImageStackView: DetailImageStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func bindViewModel() {
        //MARK: - navigationController가 왜 없을까?
        
        rx.viewWillAppear
            .take(1)
            .map{ _ in }
            .bind(to: viewModel.fetchItem)
            .disposed(by: rx.disposeBag)
        
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
    }
}
