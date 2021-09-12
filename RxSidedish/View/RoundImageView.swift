//
//  SidedishThumbnailImage.swift
//  RxSidedish
//
//  Created by Issac on 2021/09/06.
//

import UIKit

@IBDesignable
final class RoundImageView: UIImageView {
    
    @IBInspectable private var cornerRadius: Bool = false {
        didSet {
            layer.cornerRadius = frame.width / 10
        }
    }
}
