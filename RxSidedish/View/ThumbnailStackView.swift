//
//  ThumbnailStackView.swift
//  RxSidedish
//
//  Created by Issac on 2021/09/07.
//

import UIKit

final class ThumbnailStackView: UIStackView {
    
    func addArrangedImageView(image: UIImage?, width: CGFloat?) {
        guard let width = width else  {
            return
        }
        
        let resizeImage = image?.resize(newWidth: width)
        let imageView = UIImageView(image: resizeImage)
        imageView.contentMode = .scaleAspectFill
        
        addArrangedSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: width),
            imageView.heightAnchor.constraint(equalToConstant: frame.height)
        ])
    }
}
