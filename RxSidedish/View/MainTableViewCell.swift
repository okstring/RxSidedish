//
//  MainTableViewCell.swift
//  RxSidedish
//
//  Created by Issac on 2021/09/02.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var sidedishTitle: UILabel!
    @IBOutlet weak var sidedishDescription: UILabel!
    @IBOutlet weak var sidedishImageView: UIImageView!
    @IBOutlet weak var nPrice: UILabel!
    @IBOutlet weak var sPrice: UILabel!
    @IBOutlet weak var eventBadge: UILabel!
    @IBOutlet weak var launchingBadge: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        eventBadge.isHidden = false
        launchingBadge.isHidden = false
    }
    
    private func setView() {
        sidedishImageView.layer.masksToBounds = false
        sidedishImageView.layer.cornerRadius = sidedishImageView.frame.width / 2
        
        for view in [eventBadge, launchingBadge] {
            view?.layer.cornerRadius = view!.frame.width / 20
            view?.layer.masksToBounds = true
        }
    }
    
    func configure(item: SidedishItem) {
        sidedishTitle.text = item.title
        sidedishDescription.text = item.itemDescription
        nPrice.text = "\(item.nPrice)원"
        sPrice.text = "\(item.sPrice)원"
        eventBadge.isHidden = !item.hasEventBadge
        launchingBadge.isHidden = !item.hasLaunchingBadge
    }
}
