//
//  MainTableViewCell.swift
//  RxSidedish
//
//  Created by Issac on 2021/09/02.
//

import UIKit
import Alamofire
import RxSwift

class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var sidedishTitle: UILabel!
    @IBOutlet weak var sidedishDescription: UILabel!
    @IBOutlet weak var sidedishImageView: RoundImageView!
    @IBOutlet weak var nPrice: UILabel!
    @IBOutlet weak var sPrice: UILabel!
    @IBOutlet weak var eventBadge: RoundBadgeLabel!
    @IBOutlet weak var launchingBadge: RoundBadgeLabel!
    var downloadDisposable: Disposable?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        downloadDisposable?.dispose()
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
        loadImage(imageURL: item.imageURL)
    }
    
    func loadImage(imageURL: String) {
        let imageWidth = self.sidedishImageView.bounds.width
        downloadDisposable = ImageLoader.load(from: imageURL)
            .drive(onNext: { [weak self] image in
                self?.sidedishImageView.image = image?.resize(newWidth: imageWidth)
            })
    }
}
