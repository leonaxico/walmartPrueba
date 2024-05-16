//
//  CreateProductViewController.swift
//  walmartDemo
//
//  Created by Axel Iván Solano González on 13/05/24.
//

import UIKit

class CreateProductViewController: UIViewController {
    var product:Product? { 
        didSet {
            imageTextField.text = product?.imageURL
            productTextField.text = product?.productName
            if let price = product?.productPrice{
                priceTextField.text = String(format: "%.2f", price)
            }
            categoryTextField.text = product?.category
            skuTextField.text = product?.sku
            sendButton.setTitle("Actualizar", for: .normal)
        }
    }
    
    lazy var imageIcon:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo.artframe")
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var imageLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        label.text = "URL imagen: "
        return label
    }()
    
    lazy var imageTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "http://someimageurl.com/image"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .alphabet
        textField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var imageStack:UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        [imageIcon, imageLabel, imageTextField].forEach { view in
            stack.addArrangedSubview(view)
        }
        stack.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return stack
    }()
    
    lazy var productIcon:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "bag.fill")
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var productLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        label.text = "Nombre: "
        return label
    }()
    
    lazy var productTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Nombre producto"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .alphabet
        textField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var productStack:UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        [productIcon, productLabel, productTextField].forEach { view in
            stack.addArrangedSubview(view)
        }
        stack.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return stack
    }()
    
    lazy var priceIcon:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "dollarsign.circle.fill")
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var priceLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        label.text = "Precio: "
        return label
    }()
    
    lazy var priceTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "$$$$$$"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numbersAndPunctuation
        textField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var priceStack:UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        [priceIcon, priceLabel, priceTextField].forEach { view in
            stack.addArrangedSubview(view)
        }
        stack.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return stack
    }()
    
    lazy var skuIcon:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "tag")
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var skuLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        label.text = "Sku: "
        return label
    }()
    
    lazy var skuTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "ab12345678"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .alphabet
        textField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var skuStack:UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        [skuIcon, skuLabel, skuTextField].forEach { view in
            stack.addArrangedSubview(view)
        }
        stack.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return stack
    }()
    
    lazy var categoryIcon:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "cart.fill")
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var categoryLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        label.text = "Categoria: "
        return label
    }()
    
    lazy var categoryTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Abarrotes"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .alphabet
        textField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var categoryStack:UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        [categoryIcon, categoryLabel, categoryTextField].forEach { view in
            stack.addArrangedSubview(view)
        }
        stack.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return stack
    }()
    
    lazy var sendButton:UIButton = {
        let button = UIButton()
        button.setTitle("Crear", for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.addTarget(self, action: #selector(createProduct), for: .touchUpInside)
        return button
    }()
    
    lazy var viewsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        [imageStack, productStack, priceStack, skuStack, categoryStack, sendButton].forEach { view in
            stack.addArrangedSubview(view)
        }
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(viewsStack)
        viewsStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        viewsStack.trailingAnchor.constraint(equalTo:  self.view.trailingAnchor, constant: -10).isActive = true
        viewsStack.centerYAnchor.constraint(equalTo:  self.view.centerYAnchor).isActive = true
        self.view.clipsToBounds = true
    }
    
    @objc func createProduct() {
        if let product = product, let id = product.id {
            ProductRequestsManager().updateProduct(id: String(id), product: product) { product, error in
                if error != nil {
                    let alert = UIAlertController(title: nil, message: "Error al guardar!", preferredStyle: .alert)
                    self.present(alert, animated: true)
                    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in alert.dismiss(animated: true)}
                } else {
                    self.dismiss(animated: true)
                }
            }
        } else {
            if let name = productTextField.text, let price = priceTextField.text, let priceDouble = Double(price), let sku = skuTextField.text, let category = categoryTextField.text{
                let newProduct = Product(id: nil, productName: name, productPrice: priceDouble, imageURL: imageTextField.text, sku: sku, category: category)
                ProductRequestsManager().newProduct(product: newProduct) { product, error in
                    if error != nil {
                        let alert = UIAlertController(title: nil, message: "Error al guardar!", preferredStyle: .alert)
                        self.present(alert, animated: true)
                        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in alert.dismiss(animated: true)}
                    } else {
                        self.dismiss(animated: true)
                    }
                }
            }
        }
    }
}
