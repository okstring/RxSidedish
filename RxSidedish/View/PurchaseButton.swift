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
}
