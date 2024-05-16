//
//  NameTableCell.swift
//  walmart
//
//  Created by Axel Iván Solano González on 13/05/24.
//

import UIKit

class NameTableCell: UITableViewCell {
    public static let identifier = "nameTableCell"
    
    lazy var myImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.fill")
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var nameLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        label.text = "Nombre: "
        return label
    }()
    
    lazy var textField:UITextField  = {
        let textField = UITextField()
        textField.placeholder = "Juanito Alcachofa"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .alphabet
        textField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(endEditingNAme), for: .editingDidEnd)
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(myImageView)
        myImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        myImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        contentView.addSubview(nameLabel)
        nameLabel.leftAnchor.constraint(equalTo: myImageView.rightAnchor, constant: 10).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        contentView.addSubview(textField)
        textField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        textField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 10).isActive = true
        textField.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(name: String) {
        textField.text = name
        textField.isEnabled = false
        
    }
    
    @objc func endEditingNAme() {
        NotificationCenter.default.post(name: .enableLoggin, object: nil, userInfo: ["name": textField.text ?? ""])
    }
}
