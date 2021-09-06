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
    @IBOutlet weak var eventBadge: RoundBadgeLabel!
    @IBOutlet weak var launchingBadge: RoundBadgeLabel!
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0))
    }
    
    private func setView() {
        for view in [eventBadge, launchingBadge] {
            view?.cornerRadius = true
        }
    }
    
    func configure(item: SidedishItem) {
        sidedishTitle.text = item.title
        sidedishDescription.text = item.itemDescription
        nPrice.text = item.nPrice
        sPrice.text = item.sPrice
        eventBadge.isHidden = !item.hasEventBadge
        launchingBadge.isHidden = !item.hasLaunchingBadge
        ImageLoader.load(from: item.imageURL, completionHandler: { [weak self] (image) in
            self?.sidedishImageView.image = image?.resize(newWidth: self?.sidedishImageView.bounds.width ?? 130)
        })
    }
}
