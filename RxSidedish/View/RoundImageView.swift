//
//  SidedishThumbnailImage.swift
//  RxSidedish
//
//  Created by Issac on 2021/09/06.
//

import UIKit

@IBDesignable
class RoundImageView: UIImageView {
    
    @IBInspectable var cornerRadius: Bool = false {
        didSet {
            layer.cornerRadius = frame.width / 2
        }
    }
}
