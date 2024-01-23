//
//  AssetsVC.swift
//  ILCoinCap
//
//  Created by Arina Postnikova on 23/1/24.
//

import UIKit

class AssetsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
    }
    
    func configureVC() {
        view.backgroundColor = .black
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
