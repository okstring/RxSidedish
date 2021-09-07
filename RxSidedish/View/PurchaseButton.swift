//
//  PurchaseButton.swift
//  RxSidedish
//
//  Created by Issac on 2021/09/07.
//

import UIKit
@IBDesignable
class PurchaseButton: UIButton {

    @IBInspectable var cornerRadius: Bool = false {
        didSet {
            layer.masksToBounds = true
            layer.cornerRadius = frame.width / 80
        }
    }
    
    @IBInspectable var shadow: Bool = false {
        didSet {
            layer.cornerRadius = 15
            layer.shadowColor = UIColor.gray.cgColor
            layer.shadowOpacity = 1.0
            layer.shadowOffset = CGSize.zero
            layer.shadowRadius = 10
        }
    }
}
