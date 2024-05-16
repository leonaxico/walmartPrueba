//
//  ViewController.swift
//  walmart
//
//  Created by Axel Iván Solano González on 13/05/24.
//

import UIKit

class ViewController: UIViewController {
    var products: [Product] = []
    var user: User?
    
    lazy var contentTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ImageTableCell.self, forCellReuseIdentifier: ImageTableCell.identifier)
        tableView.register(NameTableCell.self, forCellReuseIdentifier: NameTableCell.identifier)
        tableView.register(EmailTableCell.self, forCellReuseIdentifier: EmailTableCell.identifier)
        tableView.register(PasswordTableCell.self, forCellReuseIdentifier: PasswordTableCell.identifier)
        tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        // Do any additional setup after loading the view.
    }
    
    func newUpdateProductNavigation( product: Product? = nil){
        let vc: CreateProductViewController = CreateProductViewController()
        if let product = product{
            vc.product = product
        }
        vc.view.backgroundColor = .white
        self.present(vc, animated: true)
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func setupTableView() {
        self.view.addSubview(contentTableView)
        contentTableView.separatorStyle = .none
        contentTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        contentTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        contentTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let token = UserDefaults.standard.string(forKey: "authToken"), token.isEmpty && section == SectionsTableViewInfo.userPassword.rawValue {
            return 0
        }
        if section == SectionsTableViewInfo.products.rawValue {
            return products.count
        }
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionsTableViewInfo.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case SectionsTableViewInfo.tableImage.rawValue:
            guard let cell: ImageTableCell = contentTableView.dequeueReusableCell(withIdentifier: ImageTableCell.identifier) as? ImageTableCell else {return UITableViewCell()}
            if let imageURL = user?.imageURL {
                cell.configureImage(imageURL: imageURL)
            }
            return cell
        case SectionsTableViewInfo.userName.rawValue:
            guard let cell: NameTableCell = contentTableView.dequeueReusableCell(withIdentifier: NameTableCell.identifier) as? NameTableCell else {
                return UITableViewCell()}
            
            if let name = user?.name {
                cell.configure(name: name)
            }
            return cell
        case SectionsTableViewInfo.userEmail.rawValue:
            guard let cell: EmailTableCell = contentTableView.dequeueReusableCell(withIdentifier: EmailTableCell.identifier) as? EmailTableCell else {
                return UITableViewCell()}
            if let email = user?.email {
                cell.configure(email: email)
            }
            return cell
        case SectionsTableViewInfo.userPassword.rawValue:
            guard let cell: PasswordTableCell = contentTableView.dequeueReusableCell(withIdentifier: PasswordTableCell.identifier) as? PasswordTableCell else {
                return UITableViewCell()}
            return cell
        case SectionsTableViewInfo.products.rawValue:
            guard let cell: ProductCell = contentTableView.dequeueReusableCell(withIdentifier: ProductCell.identifier) as? ProductCell else {
                return UITableViewCell()
            }
            if indexPath.row < products.count {
                let product = products[indexPath.row]
                cell.configure(product: product)
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section{
        case SectionsTableViewInfo.tableImage.rawValue:
            return 200
        case SectionsTableViewInfo.userName.rawValue, SectionsTableViewInfo.userEmail.rawValue, SectionsTableViewInfo.userPassword.rawValue:
            return 40
        case  SectionsTableViewInfo.products.rawValue:
            return 90
        default:
            return contentTableView.estimatedRowHeight
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == SectionsTableViewInfo.products.rawValue {
            let actionSheet = UIAlertController(title: "Opciones", message: "Acciones del Producto", preferredStyle: .actionSheet)
            actionSheet.addAction(UIAlertAction(title: "Nuevo producto", style: .default , handler:{ (UIAlertAction) in
                self.newUpdateProductNavigation()
                actionSheet.dismiss(animated: false)
            }))
            actionSheet.addAction(UIAlertAction(title: "Actualizar", style: .default , handler:{ (UIAlertAction) in
                actionSheet.dismiss(animated: false)
                if indexPath.row < self.products.count {
                    self.newUpdateProductNavigation(product: self.products[indexPath.row
                                                                          ])
                }
            }))
            actionSheet.addAction(UIAlertAction(title: "Borrar", style: .destructive , handler:{ (UIAlertAction) in
                if indexPath.row < self.products.count,let id = self.products[indexPath.row].id{
                    ProductRequestsManager().deleteProduct(id: String(id)) { deleted, error in
                        if error == nil {
                            self.products.remove(at: indexPath.row)
                            tableView.reloadData()
                        }
                        actionSheet.dismiss(animated: true)
                    }
                }
            }))
            actionSheet.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler:{ (UIAlertAction) in
                print("User click Dismiss button")
            }))
            self.present(actionSheet, animated: true)
        }
    }
}


