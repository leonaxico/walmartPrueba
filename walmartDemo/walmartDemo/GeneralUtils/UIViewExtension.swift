//
//  UIViewExtension.swift
//  walmartDemo
//
//  Created by Axel Iván Solano González on 13/05/24.
//

import UIKit

extension UIView {

    var viewController: UIViewController? {
        weak var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
