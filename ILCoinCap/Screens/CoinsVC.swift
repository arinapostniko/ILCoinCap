//
//  CoinsVC.swift
//  ILCoinCap
//
//  Created by Arina Postnikova on 23/1/24.
//

import UIKit

class CoinsVC: ILDataLoadingVC {
    
    let titleLabel = ILTitleLabel()
    let searchButton = ILButton(image: .search)
    let tableView = UITableView()
    
    var coins: [CoinInfo] = []
    var filteredCoins: [CoinInfo] = []
    var offset = 0
    var isThereMoreCoins = true
    var isLoadingMoreCoins = false
    var isSearchBarHidden = true
    var isSearching = false

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureSearchController()
        configureTableView()
        
        getCoins(offset: offset)
    }
    
    private func configureVC() {
        view.backgroundColor = .black
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.addSubviews(titleLabel, searchButton)
        
        titleLabel.text = "Trending Coins"
        searchButton.addTarget(self, action: #selector(showSearchBar), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 17.5),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.heightAnchor.constraint(equalToConstant: 29),
            
            searchButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchButton.heightAnchor.constraint(equalToConstant: 40),
            searchButton.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc
    func showSearchBar() {
        isSearchBarHidden = false
        titleLabel.isHidden = true
        searchButton.isHidden = true
        navigationController?.setNavigationBarHidden(isSearchBarHidden, animated: false)
    }
    
    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a coin"
        searchController.searchBar.showsCancelButton = true
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = .zero
        tableView.rowHeight = 72
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CoinCell.self, forCellReuseIdentifier: ReuseIDs.coinCell)
        
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
                updateUI(with: coins)
            case .failure(let error):
                presentAlertOnMainThread(with: error)
            }
            
            self.isLoadingMoreCoins = false
        }
    }
    
    func updateUI(with coins: [CoinInfo]) {
        if coins.count < 10 { self.isThereMoreCoins = false }
        self.coins.append(contentsOf: coins)
        DispatchQueue.main.async { self.tableView.reloadData() }
    }
    
    func presentAlertOnMainThread(with error: ILError) {
        DispatchQueue.main.async {
            let alert = ILAlertVC()
            alert.configure(title: .somethingWentWrong, message: error.rawValue)
            alert.addAction(title: "OK", style: .default) { _ in
                self.dismiss(animated: true)
            }
            
            alert.present(from: self)
        }
    }
}

extension CoinsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchBarHidden ? coins.count : filteredCoins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIDs.coinCell) as! CoinCell
        let coin = isSearchBarHidden ? coins[indexPath.row] : filteredCoins[indexPath.row]
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredCoins : coins
        let coin = activeArray[indexPath.row]
        
        let destVC = InfoVC(coin: coin)
        let navController = UINavigationController(rootViewController: destVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
}

extension CoinsVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredCoins.removeAll()
            tableView.reloadData()
            isSearching = false
            return
        }
        
        isSearching = true
        
        NetworkManager.shared.searchCoins(searchTerm: filter) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let coins):
                self.filteredCoins = coins
                DispatchQueue.main.async { self.tableView.reloadData() }
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
}

extension CoinsVC: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearchBarHidden = true
        titleLabel.isHidden = false
        searchButton.isHidden = false
        navigationController?.setNavigationBarHidden(isSearchBarHidden, animated: false)
    }
}
