//
//  InfoVC.swift
//  ILCoinCap
//
//  Created by Arina Postnikova on 24/1/24.
//

import UIKit

class InfoVC: UIViewController {
    
    let backgroundView = ILBackgroundView()
    let backgroundBlur = UIView()
    let dismissVCButton = ILButton(image: .chevronLeft)
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
        configureBackground()
        configureStackView()
        layoutUI()
    }
    
    private func configureBackground() {
        view.backgroundColor = .black
        view.addSubviews(backgroundView, backgroundBlur)
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.frame = view.bounds
        
        let blurEffect = UIBlurEffect(style: .systemThinMaterial)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = view.bounds
        
        backgroundView.addSubview(blurView)
        backgroundBlur.translatesAutoresizingMaskIntoConstraints = false
        backgroundBlur.backgroundColor = .black.withAlphaComponent(0.8)
        backgroundBlur.frame = view.bounds
    }
    
    private func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.addArrangedSubview(marketCapItem)
        
        let separator1 = createSeparatorView()
        stackView.addArrangedSubview(separator1)
        
        stackView.addArrangedSubview(supplyItem)
        
        let separator2 = createSeparatorView()
        stackView.addArrangedSubview(separator2)
        
        stackView.addArrangedSubview(volume24HrItem)
        
        marketCapItem.set(itemInfoType: .marketCap, with: coin.marketCapUsd ?? "")
        supplyItem.set(itemInfoType: .supply, with: coin.supply ?? "")
        volume24HrItem.set(itemInfoType: .volume24Hr, with: coin.volumeUsd24Hr ?? "")
    }
    
    private func createSeparatorView() -> UIView {
        let separatorView = UIView()
        separatorView.backgroundColor = .quaternaryLabel
        
        NSLayoutConstraint.activate([
            separatorView.widthAnchor.constraint(equalToConstant: 1),
            separatorView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        return separatorView
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
            
            stackView.topAnchor.constraint(equalTo: priceUsdLabel.bottomAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 59)
        ])
        
        dismissVCButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        coinNameLabel.text = coin.name
        priceUsdLabel.text = coin.priceUsd?.formatAsPriceUsd()
        changePercent24HrLabel.text = coin.changePercent24Hr?.formatChangePercent24Hr()
        
        let changePercent24Hr = coin.changePercent24Hr?.formatChangePercentage() ?? ""
        
        if changePercent24Hr.hasPrefix("-") {
            changePercent24HrLabel.textColor = .systemRed
        } else {
            changePercent24HrLabel.textColor = .systemGreen
            changePercent24HrLabel.text = "+" + changePercent24Hr
        }
    }
    
    @objc
    func dismissVC() {
        navigationController?.popViewController(animated: true)
    }
}
