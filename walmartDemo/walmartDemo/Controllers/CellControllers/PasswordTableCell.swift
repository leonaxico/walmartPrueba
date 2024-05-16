//
//  PasswordTableCell.swift
//  walmartDemo
//
//  Created by Axel Iván Solano González on 13/05/24.
//

import UIKit

class PasswordTableCell: UITableViewCell {
    public static let identifier = "passwordTableCell"
    var email:String = ""
    var name:String = ""
    
    lazy var myImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "lock.fill")
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
        label.text = "Contrasña: "
        return label
    }()
    
    lazy var textField: UITextField  = {
        let textField = UITextField()
        textField.placeholder = "**********"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .alphabet
        textField.isSecureTextEntry = true
        textField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var logginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Loggin", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(loggin), for: .touchUpInside)
        return button
    }()
    
    lazy var viewsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        [myImageView, nameLabel, textField, logginButton].forEach { view in
            stack.addArrangedSubview(view)
        }
        stack.heightAnchor.constraint(equalToConstant: 30).isActive = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(viewsStack)
        viewsStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        viewsStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        viewsStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        NotificationCenter.default.addObserver(self, selector: #selector(handlePasswordNotification(_:)), name: .enableLoggin, object: nil)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handlePasswordNotification(_ sender: Notification) {
        if let email = sender.userInfo?["email"] as? String {
            self.email = email
        }
        if let name = sender.userInfo?["name"] as? String {
            self.name = name
        }
        if let password = textField.text, !email.isEmpty && !name.isEmpty && !password.isEmpty {
            logginButton.isEnabled = true
        } else {
            logginButton.isEnabled = false
        }
    }
    
    @objc func loggin() {
        guard let parentController = self.viewController as? ViewController else { return }
        UserRequestsManager().logginUser { response, error in
            if error != nil {
                let alert = UIAlertController(title: nil, message: "Error al loggear!", preferredStyle: .alert)
                parentController.present(alert, animated: true)
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in alert.dismiss(animated: true)}
            } else {
                UserRequestsManager().userInfo { user, error in
                    if let user = user {
                        parentController.user = user
                    }
                    parentController.contentTableView.reloadData()
                }
                ProductRequestsManager().products { products, error in
                    if let products = products {
                        parentController.products = products
                        parentController.contentTableView.reloadData()
                    }
                }
                
            }
        }
    }
    
}
