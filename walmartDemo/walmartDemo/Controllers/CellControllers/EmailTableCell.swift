//
//  EmailTableCell.swift
//  walmart
//
//  Created by Axel Iván Solano González on 13/05/24.
//

import UIKit

class EmailTableCell: UITableViewCell {
    public static let identifier = "emailTableCell"
    
    lazy var myImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "envelope.fill")
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
        label.text = "Email: "
        return label
    }()
    
    lazy var textField:UITextField  = {
        let textField = UITextField()
        textField.placeholder = "some@some.com"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        textField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(validateEmail(_:)), for: .editingChanged)
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
    
    
    func configure(email: String) {
        textField.text = email
        textField.isEnabled = false
    }
    
    @objc func validateEmail(_ textField: UITextField) {
        guard let text = textField.text else {return}
        if isValidEmail(enteredEmail: text) {
            NotificationCenter.default.post(name: .enableLoggin, object: nil, userInfo: ["email": text])
        }
    }
    
    private func isValidEmail(enteredEmail:String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)

    }
}
