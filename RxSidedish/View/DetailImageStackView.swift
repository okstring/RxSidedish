//
//  DetailImageStackView.swift
//  RxSidedish
//
//  Created by Issac on 2021/09/07.
//

import UIKit

class DetailImageStackView: UIStackView {
    func addArrangedImageView(image: UIImage?, width: CGFloat?) {
        guard let width = width, let image = image else {
            return
        }
        
        let resizeImage = image.resize(newWidth: width)
        let imageView = UIImageView(image: resizeImage)
        imageView.contentMode = .scaleAspectFill
        
        addArrangedSubview(imageView)
        
        let scale = width / image.size.width
        let height = image.size.height * scale
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: width),
            imageView.heightAnchor.constraint(equalToConstant: height)
        ])
    }
}

