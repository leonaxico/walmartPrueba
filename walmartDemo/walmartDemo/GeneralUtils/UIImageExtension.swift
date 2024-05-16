//
//  UIImageExtension.swift
//  walmartDemo
//
//  Created by Axel Iván Solano González on 13/05/24.
//

import UIKit

extension UIImageView {
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
