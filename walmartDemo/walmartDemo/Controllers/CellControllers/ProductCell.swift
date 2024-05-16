//
//  ProductCell.swift
//
//  Created by Axel Iván Solano González on 13/05/24.
//

import UIKit

class ProductCell: UITableViewCell {
    public static let identifier = "productCell"
    
    lazy var myImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo.artframe")
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var nameLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Producr name"
        return label
    }()
    
    lazy var priceLabel: UILabel  = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$$$"
        return label
    }()
    
    lazy var viewsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        [myImageView, nameLabel, priceLabel].forEach { view in
            stack.addArrangedSubview(view)
        }
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(viewsStack)
        viewsStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        viewsStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        viewsStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(product: Product) {
        nameLabel.text = product.productName
        priceLabel.text = "$" + String(format: "%.2f", product.productPrice)
        if let imageURL = product.imageURL {
            myImageView.setImage(from: imageURL)
        }
    }
    
}
