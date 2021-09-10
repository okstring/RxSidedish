//
//  DescriptionView.swift
//  RxSidedish
//
//  Created by Issac on 2021/09/07.
//

import UIKit

class DescriptionView: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sidedishDescription: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var point: UILabel!
    @IBOutlet weak var deliveryInfo: UILabel!
    @IBOutlet weak var deliveryFee: UILabel!
    
    func configure(item: ViewDetailSidedishItem) {
        self.titleLabel.text = item.title
        self.sidedishDescription.text = item.productDescription
        self.price.text = item.price
        self.point.text = item.point
        self.deliveryInfo.text = item.deliveryInfo
        self.deliveryFee.text = item.deliveryFee
    }
}
