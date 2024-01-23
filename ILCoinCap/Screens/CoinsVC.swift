//
//  CoinsVC.swift
//  ILCoinCap
//
//  Created by Arina Postnikova on 23/1/24.
//

import UIKit

class CoinsVC: UIViewController {
    
    let tableView = UITableView()
    var coins: [Coin] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureTableView()
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
        
        tableView.dataSource = self
        tableView.register(CoinCell.self, forCellReuseIdentifier: "CoinCell")
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
        return cell
    }
}
