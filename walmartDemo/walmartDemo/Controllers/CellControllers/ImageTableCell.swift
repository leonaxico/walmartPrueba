//
//  ImageTableCell.swift
//  walmart
//
//  Created by Axel Iván Solano González on 13/05/24.
//

import Foundation
import UIKit

class ImageTableCell: UITableViewCell {
//   using a Single class for the images later we could make a carousell or stuf like that without afecting other functions
    public static let identifier = "imageTableCell"
    
    var activeImageURL:String = "camera.metering.unknown"
    
    lazy var myImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: activeImageURL)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(myImageView)
        myImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        myImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        myImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        myImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    func configureImage(imageURL: String){
        activeImageURL = imageURL
        myImageView.setImage(from: imageURL)

    }
}
