//
//  ViewController.swift
//  CurrencyApp
//
//  Created by Maksym Teslia on 23.12.2020.
//  Copyright © 2020 Maksym Teslia. All rights reserved.
//

import UIKit

fileprivate struct Constants {
    static let cellIdentifier = "CurrencyTableCell"
    static let numberOfSectionsInCurrencyTableView = 3
    static let standardCornerRadius: CGFloat = 10
    static let currencyTableViewHeaderFont: CGFloat = 24
    static let currencyTableCellScaleHeight: CGFloat = 0.07
    static let currencyTableHeaderScaleHeight: CGFloat = 0.07
}

fileprivate struct CurrencyTableSectionsNames {
    static let commonCurrencySectionName = "Common currency"
    static let otherCurrencySecionName = "Other currency"
    static let preciousMetalsSectionName = "Precious metals"
}

class ExchangeRatesInfoViewController: UIViewController {
    let tableView = UITableView(frame: UIScreen.main.bounds, style: .grouped)
    let currencyConverterButton = UIButton()
    let configurator = ExchangeRatesInfoConfigurator()
    var viewData: ExchangeRatesInfoViewData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewData = ExchangeRatesInfoViewData(delegate: self)
        
        configurator.setUpCurrencyConverterButton(currencyConverterButton, withViewController: self)
        
        currencyConverterButton.addTarget(self,
                                          action: #selector(currencyConverterButtonHasBeenPushed(_:)),
                                          for: .touchUpInside)
        view.addSubview(tableView)
        tableView.backgroundView = ExchangeEmptyView.loadFromNib()
        
        viewData?.getCurrencyInformation()
    }
    
    @objc func currencyConverterButtonHasBeenPushed(_ sender: UIButton) {
        let currencyConverterViewController = CurrencyConverterViewController()
        let viewData = CurrencyConverterInfoViewData(delegate: currencyConverterViewController,
                                                     commonMoneyCurrencies: self.viewData.commonMoneyCurrencies, otherMoneyCurrencies: self.viewData.aboutOtherMoneyCurrencies,
                                                     allPreciousMetalsCurrencies: self.viewData.aboutAllPreciousMetals)
        currencyConverterViewController.viewData = viewData
        currencyConverterViewController.modalPresentationStyle = .fullScreen
        present(currencyConverterViewController, animated: true)
    }
}

extension ExchangeRatesInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.numberOfSectionsInCurrencyTableView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return viewData.commonMoneyCurrencies.count
        case 1: return viewData.aboutOtherMoneyCurrencies.count
        case 2: return viewData.aboutAllPreciousMetals.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let viewForHeader = UILabel()
        viewForHeader.layer.cornerRadius = Constants.standardCornerRadius
        viewForHeader.backgroundColor = .clear
        viewForHeader.textAlignment = .center
        viewForHeader.textColor = .black
        viewForHeader.font = .boldSystemFont(ofSize: Constants.currencyTableViewHeaderFont)
        
        switch section {
        case 0: viewForHeader.text = CurrencyTableSectionsNames.commonCurrencySectionName
        case 1: viewForHeader.text = CurrencyTableSectionsNames.otherCurrencySecionName
        case 2: viewForHeader.text = CurrencyTableSectionsNames.preciousMetalsSectionName
        default: viewForHeader.text = ""
        }
        
        return viewForHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.view.frame.size.height * Constants.currencyTableHeaderScaleHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.size.height * Constants.currencyTableCellScaleHeight
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currencyTableViewCell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as! CurrencyTableCellClass
        switch indexPath.section {
        case 0: let moneyCurrencyInformationObject = viewData.commonMoneyCurrencies[indexPath.row]
        currencyTableViewCell.configureCurrencyTableCell(currencyModel: moneyCurrencyInformationObject)
            
        case 1: let moneyCurrencyInformationObject = viewData.aboutOtherMoneyCurrencies[indexPath.row]
        currencyTableViewCell.configureCurrencyTableCell(currencyModel: moneyCurrencyInformationObject)
            
        case 2: let moneyCurrencyInformationObject = viewData.aboutAllPreciousMetals[indexPath.row]
        currencyTableViewCell.configureCurrencyTableCell(currencyModel: moneyCurrencyInformationObject)
            
        default:
            break
        }
        
        return currencyTableViewCell
    }
}

//MARK: - ExchangeRateViewDataDelegate

extension ExchangeRatesInfoViewController: ExchangeRatesInfoViewDataDelegate {
    func currencyDataDidFetch() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.backgroundView = nil
            self.configurator.configureCurrencyTable(self.tableView, withAViewController: self)
        }
    }
}


