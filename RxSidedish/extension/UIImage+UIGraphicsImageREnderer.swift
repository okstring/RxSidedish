//
//  UIImage+UIGraphicsImageREnderer.swift
//  RxSidedish
//
//  Created by Issac on 2021/08/31.
//

import UIKit

extension UIImage {
    func resize(newWidth: CGFloat) -> UIImage {
        let scale = newWidth / self.size.width
        let newHelght = self.size.height * scale
        
        let size = CGSize(width: newWidth, height: newHelght)
        let render = UIGraphicsImageRenderer(size: size)
        let renderImage = render.image { (context) in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
        return renderImage
    }
}
