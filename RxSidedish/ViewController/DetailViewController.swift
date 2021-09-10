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
import NSObject_Rx

class DetailViewController: UIViewController, ViewModelBindableType {
    var viewModel: DetailViewModel!
    
    @IBOutlet weak var thumbnailStackView: ThumbnailStackView!
    @IBOutlet weak var descriptionView: DescriptionView!
    @IBOutlet weak var detailImageStackView: DetailImageStackView!
    
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
        
        viewModel.item
            .subscribe(onNext: { [weak self] title, item in
                self?.descriptionView.configure(title: title, item: item)
            }).disposed(by: rx.disposeBag)
        
        viewModel.item
            .map({ $1.thumbnailImagesURL })
            .flatMap({ Observable.from($0) })
            .flatMap({ ImageLoader.load(from: $0) })
            .subscribe(onNext: { [weak self] image in
                self?.thumbnailStackView.addArrangedImageView(image: image, width: self?.view.bounds.width)
            }).disposed(by: rx.disposeBag)
        
        viewModel.item
            .map({ $1.detailSectionImagesURL })
            .flatMap({ Observable.from($0) })
            .flatMap({ ImageLoader.load(from: $0) }) //MARK: - 뷰 모델로 옮길수 있지 않을까?
            .subscribe(onNext: { [weak self] image in
                self?.detailImageStackView.addArrangedImageView(image: image, width: self?.view.bounds.width)
            }).disposed(by: rx.disposeBag)
        
        
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
    }
}
