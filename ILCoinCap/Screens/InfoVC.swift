//
//  InfoVC.swift
//  ILCoinCap
//
//  Created by Arina Postnikova on 24/1/24.
//

import UIKit

class InfoVC: UIViewController {
    
    let dismissVCButton = ILButton(image: "chevron.left")
    let coinNameLabel = ILTitleLabel()
    let priceUsdLabel = ILBodylabel(fontSize: 24, textAlignment: .left, textColor: .label)
    let changePercent24HrLabel = ILBodylabel(fontSize: 14, textAlignment: .left, textColor: .systemGreen)
    let stackView = UIStackView()
    let marketCapItem = ILItemInfoView()
    let supplyItem = ILItemInfoView()
    let volume24HrItem = ILItemInfoView()
    
    var coin: CoinInfo!
    
    init(coin: CoinInfo) {
        super.init(nibName: nil, bundle: nil)
        self.coin = coin
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureStackView()
        layoutUI()
    }
    
    private func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(marketCapItem)
        stackView.addArrangedSubview(supplyItem)
        stackView.addArrangedSubview(volume24HrItem)
        
        marketCapItem.set(itemInfoType: .marketCap, with: coin.marketCapUsd ?? "")
        supplyItem.set(itemInfoType: .supply, with: coin.supply ?? "")
        volume24HrItem.set(itemInfoType: .volume24Hr, with: coin.volumeUsd24Hr ?? "")
    }
    
    private func layoutUI() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.addSubviews(dismissVCButton, coinNameLabel, priceUsdLabel, changePercent24HrLabel, stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dismissVCButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            dismissVCButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dismissVCButton.heightAnchor.constraint(equalToConstant: 40),
            dismissVCButton.widthAnchor.constraint(equalToConstant: 40),
            
            coinNameLabel.centerYAnchor.constraint(equalTo: dismissVCButton.centerYAnchor),
            coinNameLabel.leadingAnchor.constraint(equalTo: dismissVCButton.trailingAnchor, constant: 16),
            coinNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            coinNameLabel.heightAnchor.constraint(equalToConstant: 29),
            
            priceUsdLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 84),
            priceUsdLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            priceUsdLabel.heightAnchor.constraint(equalToConstant: 29),
            
            changePercent24HrLabel.centerYAnchor.constraint(equalTo: priceUsdLabel.centerYAnchor),
            changePercent24HrLabel.leadingAnchor.constraint(equalTo: priceUsdLabel.trailingAnchor, constant: 10),
            changePercent24HrLabel.heightAnchor.constraint(equalToConstant: 17),
            changePercent24HrLabel.widthAnchor.constraint(equalToConstant: 116),
            
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 125),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 59)
        ])
        
        dismissVCButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        coinNameLabel.text = coin.name
        priceUsdLabel.text = coin.priceUsd?.formatAsCurrency()
        changePercent24HrLabel.text = coin.changePercent24Hr?.formatChangePercentage()
    }
    
    @objc
    func dismissVC() {
        dismiss(animated: true)
    }
}
