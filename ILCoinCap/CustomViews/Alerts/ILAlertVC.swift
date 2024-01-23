//
//  ILAlertVC.swift
//  ILCoinCap
//
//  Created by Arina Postnikova on 23/1/24.
//

import UIKit

class ILAlertVC: UIAlertController {
    
    func configure(title: String, message: String) {
        self.title = title
        self.message = message
    }
    
    func addAction(title: String, style: UIAlertAction.Style = .default, handler: ((UIAlertAction) -> Void)? = nil) {
        let action = UIAlertAction(title: title, style: style, handler: handler)
        addAction(action)
    }
    
    func present(from viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        viewController.present(self, animated: animated, completion: completion)
    }
}
