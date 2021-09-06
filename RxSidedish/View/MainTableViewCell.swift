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
    @IBOutlet weak var sidedishImageView: RoundImageView!
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
        sidedishImageView.image = nil
        eventBadge.isHidden = false
        launchingBadge.isHidden = false
    }
    
    private func setView() {
        for view in [eventBadge, launchingBadge] {
            view?.layer.cornerRadius = view!.frame.width / 20
            view?.layer.masksToBounds = true
        }
    }
    
    func configure(item: SidedishItem) {
        sidedishTitle.text = item.title
        sidedishDescription.text = item.itemDescription
        nPrice.text = item.nPrice
        sPrice.text = "\(item.sPrice)원"
        eventBadge.isHidden = !item.hasEventBadge
        launchingBadge.isHidden = !item.hasLaunchingBadge
        ImageLoader.load(from: item.imageURL, completionHandler: { [weak self] (image) in
            self?.sidedishImageView.image = image?.resize(newWidth: self?.sidedishImageView.frame.width ?? 130)
        })
    }
}
