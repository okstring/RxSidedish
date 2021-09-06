//
//  ViewController.swift
//  RxSidedish
//
//  Created by Issac on 2021/08/30.
//

import UIKit

class MainViewController: UIViewController, ViewModelBindableType {
    var viewModel: MainViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getSidedishes()
    }
    
    func bindViewModel() {
        
    }
}
