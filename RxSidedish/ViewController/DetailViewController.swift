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

final class DetailViewController: UIViewController, ViewModelBindableType {
    var viewModel: DetailViewModel!
    
    @IBOutlet weak var thumbnailStackView: ThumbnailStackView!
    @IBOutlet weak var descriptionView: DescriptionView!
    @IBOutlet weak var detailImageStackView: DetailImageStackView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func bindViewModel() {
        rx.viewWillAppear
            .take(1)
            .map{ _ in }
            .bind(to: viewModel.fetchItem)
            .disposed(by: rx.disposeBag)
        
        viewModel.sidedishItem
            .subscribe(onNext: { [weak self] item in
                self?.descriptionView.configure(item: item)
            }).disposed(by: rx.disposeBag)
        
        viewModel.thumbnailImagesURL
            .flatMap({ ImageLoader.load(from: $0) })
            .subscribe(onNext: { [weak self] image in
                self?.thumbnailStackView.addArrangedImageView(image: image, width: self?.view.bounds.width)
            }).disposed(by: rx.disposeBag)
        
        viewModel.detailSectionImageURL
            .flatMap({ ImageLoader.load(from: $0) }) 
            .subscribe(onNext: { [weak self] image in
                self?.detailImageStackView.addArrangedImageView(image: image, width: self?.view.bounds.width)
            }).disposed(by: rx.disposeBag)
        
        
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
    }
}
