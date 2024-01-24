//
//  CoinsVC.swift
//  ILCoinCap
//
//  Created by Arina Postnikova on 23/1/24.
//

import UIKit

class CoinsVC: ILDataLoadingVC {
    
    let titleLabel = ILTitleLabel()
    let searchButton = ILButton(image: "magnifyingglass")
    let tableView = UITableView()
    
    var coins: [CoinInfo] = []
    var offset = 0
    var isThereMoreCoins = true
    var isLoadingMoreCoins = false

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureTableView()
        
        getCoins(offset: offset)
    }
    
    func configureVC() {
        view.backgroundColor = .black
        view.addSubviews(titleLabel, searchButton)
        titleLabel.text = "Trending Coins"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 17.5),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.heightAnchor.constraint(equalToConstant: 29),
            titleLabel.widthAnchor.constraint(equalToConstant: 213),
            
            searchButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchButton.heightAnchor.constraint(equalToConstant: 40),
            searchButton.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = .zero
        tableView.rowHeight = 72
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CoinCell.self, forCellReuseIdentifier: "CoinCell")
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func getCoins(offset: Int) {
        showLoadingView()
        isLoadingMoreCoins = true
        
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
            
            self.isLoadingMoreCoins = false
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

extension CoinsVC: UITableViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard isThereMoreCoins, !isLoadingMoreCoins else { return }
            offset += 10
            getCoins(offset: offset)
        }
    }
}
