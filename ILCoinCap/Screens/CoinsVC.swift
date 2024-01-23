//
//  CoinsVC.swift
//  ILCoinCap
//
//  Created by Arina Postnikova on 23/1/24.
//

import UIKit

class CoinsVC: ILDataLoadingVC {
    
    let tableView = UITableView()
    
    var coins: [CoinInfo] = []
    var offset = 0
    var isThereMoreCoins = true

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureTableView()
        
        getCoins(offset: offset)
    }
    
    func configureVC() {
        view.backgroundColor = .black
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 72
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
        tableView.dataSource = self
        tableView.register(CoinCell.self, forCellReuseIdentifier: "CoinCell")
    }
    
    func getCoins(offset: Int) {
        showLoadingView()
        
        NetworkManager.shared.getCoins(offset: offset) { [weak self] result in
            guard let self else { return }
            
            self.dismissLoadingView()
            
            switch result {
            case .success(let coins):
                if coins.count < 10 { self.isThereMoreCoins = false }
                self.coins.append(contentsOf: coins)
                DispatchQueue.main.async { self.tableView.reloadData() }
            case .failure(let error):
                DispatchQueue.main.async {
                    let alert = ILAlertVC()
                    alert.configure(title: "Something Went Wrong", message: error.rawValue)
                    alert.addAction(title: "OK", style: .default) { _ in
                        self.dismiss(animated: true)
                    }
                    
                    alert.present(from: self)
                }
            }
        }
    }
}

extension CoinsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoinCell") as! CoinCell
        let coin = coins[indexPath.row]
        cell.set(coin: coin)
        cell.selectionStyle = .none
        return cell
    }
}
