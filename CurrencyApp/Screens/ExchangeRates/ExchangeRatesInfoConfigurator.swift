//
//  ExchangeRatesInfoConfigurator.swift
//  CurrencyApp
//
//  Created by Maksym Teslia on 23.12.2020.
//  Copyright © 2020 Maksym Teslia. All rights reserved.
//

import Foundation
import UIKit

fileprivate struct Constants {
    static let cellIdentifier = "CurrencyTableCell"
    static let currencyConverterButtonName = "Currency converter"
    static let waitingLabelText = "Getting actual exchange rates..."
}

fileprivate struct UIElementsScaleSizes {
    static let currencyTableViewScaleHeight:CGFloat = 0.75
    static let currencyTableViewSideSpaceConstraint:CGFloat = 10
    static let currencyConverterButtonCornerRadius:CGFloat = 5
    static let curreencyConverterButtonBorderSize:CGFloat = 0.2
    static let currencyConverterButtonSideSpaceConstraint:CGFloat = 50
    static let currencyConverterButtonScaleHeight:CGFloat = 0.075
    static let waitingLabelScaleWidth:CGFloat = 0.8
    static let waitingLabelScaleHeight:CGFloat = 0.4
}

class ExchangeRatesInfoConfigurator {
    
        func configureCurrencyTable(_ table: UITableView, withAViewController viewController: UIViewController) {
        viewController.view.addSubview(table)
        table.backgroundColor = .clear
        table.frame = CGRect(x: viewController.view.frame.origin.x,
                             y: viewController.view.frame.origin.y,
                             width: viewController.view.frame.width,
                             height: viewController.view.frame.height * UIElementsScaleSizes.currencyTableViewScaleHeight)
        
        table.delegate = viewController as? UITableViewDelegate
        table.dataSource = viewController as? UITableViewDataSource
        table.allowsSelection = false
        table.separatorColor = .clear
        
        table.register(CurrencyTableCellClass.self, forCellReuseIdentifier: Constants.cellIdentifier)
        
        let oneFifthOfTheView = viewController.view.frame.size.height * 0.2
        let oneTenthOfTheView = viewController.view.frame.size.height * 0.1
        
        table.translatesAutoresizingMaskIntoConstraints = false
        
        table.topAnchor.constraint(equalTo: viewController.view.topAnchor, constant: oneTenthOfTheView).isActive = true
        table.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor, constant: UIElementsScaleSizes.currencyTableViewSideSpaceConstraint).isActive = true
        table.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor, constant: -UIElementsScaleSizes.currencyTableViewSideSpaceConstraint).isActive = true
        table.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor, constant: -oneFifthOfTheView).isActive = true
        
        let tableHeaderView = UIView()
        let labelForTableViewHeader = UILabel()
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let currentDateForTableHeaderView = dateFormatter.string(from: currentDate)
        
        tableHeaderView.frame = CGRect(x: 0, y: 0, width: table.frame.width, height: table.frame.height * 0.18)
        
        labelForTableViewHeader.frame = tableHeaderView.frame
        
        labelForTableViewHeader.numberOfLines = 0
        labelForTableViewHeader.text =
        " Exchange rate to hryvnia\n \(currentDateForTableHeaderView)"
        labelForTableViewHeader.textAlignment = .left
        labelForTableViewHeader.font = .boldSystemFont(ofSize: labelForTableViewHeader.frame.height * 0.25)
        labelForTableViewHeader.textColor = .black
        
        tableHeaderView.addSubview(labelForTableViewHeader)
        
        table.tableHeaderView = tableHeaderView
    }
    
    //MARK: - Function for configuring the button which is going to arrange user transition to converter screen
    
        func setUpCurrencyConverterButton(_ button: UIButton, withViewController viewController: UIViewController) {
        viewController.view.addSubview(button)
        button.backgroundColor = .systemGroupedBackground
        button.layer.cornerRadius = UIElementsScaleSizes.currencyConverterButtonCornerRadius
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.borderWidth = UIElementsScaleSizes.curreencyConverterButtonBorderSize
        
        button.frame = CGRect(x: 0,
                              y: 0,
                              width: viewController.view.frame.width * 0.5,
                              height: viewController.view.frame.height * 0.1)
        
        let oneTenthOfTheView = viewController.view.frame.size.height * 0.1
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Constants.currencyConverterButtonName, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: button.frame.height * 0.25)
        
        button.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor, constant: UIElementsScaleSizes.currencyConverterButtonSideSpaceConstraint).isActive = true
        button.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor, constant: -UIElementsScaleSizes.currencyConverterButtonSideSpaceConstraint).isActive = true
        button.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor, constant: -oneTenthOfTheView).isActive = true
        button.heightAnchor.constraint(equalTo: viewController.view.heightAnchor, multiplier: UIElementsScaleSizes.currencyConverterButtonScaleHeight).isActive = true
    }
}
