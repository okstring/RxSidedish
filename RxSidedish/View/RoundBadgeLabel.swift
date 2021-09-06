//
//  RoundBadgeLabel.swift
//  RxSidedish
//
//  Created by Issac on 2021/09/06.
//

import UIKit

@IBDesignable
class RoundBadgeLabel: UILabel {
    
    @IBInspectable var cornerRadius: Bool = false {
        didSet {
            layer.masksToBounds = true
            layer.cornerRadius = frame.width / 15
        }
    }

}
