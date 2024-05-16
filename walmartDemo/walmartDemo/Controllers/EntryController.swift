//
//  EntryController.swift
//  walmartDemo
//
//  Created by Axel Iván Solano González on 13/05/24.
//

import Foundation

import UIKit

class EntryController: UIViewController {
    lazy var loginButton: UIButton = {
        let button:UIButton = UIButton()
        button.setTitle("Iniciar Sesion", for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    lazy var signUpButton: UIButton = {
        let button:UIButton = UIButton()
        button.setTitle("Crear Sesion", for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
}
