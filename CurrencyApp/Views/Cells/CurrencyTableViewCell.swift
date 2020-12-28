//
//  CurrencyTableCellClassTableViewCell.swift
//  CurrencyApp
//
//  Created by Maksym Teslia on 23.12.2020.
//  Copyright © 2020 Maksym Teslia. All rights reserved.
//

import Foundation
import UIKit

fileprivate struct Constants {
    static let identifier = "CurrencyTableCell"
    static let cornerRadius: CGFloat = 10
    static let borderWidth: CGFloat = 2
}

fileprivate struct UIElementsScaleSizes {
    static let currencyNameLabelLeadingSpace:CGFloat = 10
    static let currencyNameLabelTopSpace:CGFloat = 5
    static let currencyAndCodeLabelsFontScaleSize:CGFloat = 0.75
    static let currencyCodeLabelLeadingSpace:CGFloat = 10
    static let currencyCodeLabelBottomSpace:CGFloat = 5
    static let currencyRateLabelLeadingSpace:CGFloat = 10
    static let currencyRateLabelFontScaleSize:CGFloat = 0.5
}

class CurrencyTableCellClass: UITableViewCell {
    let currencyName = UILabel()
    let currencyCode = UILabel()
    let currencyRate = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        layer.cornerRadius = Constants.cornerRadius
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = Constants.borderWidth
        backgroundColor = .systemGroupedBackground
        configureLabelsInCell()
    }
    
    func configureCurrencyTableCell(currencyModel: CurrencyInfo) {
        self.currencyName.text = currencyModel.name
        self.currencyCode.text = currencyModel.currencyCode
        self.currencyRate.text = NSString(format: "%.3f", currencyModel.rate) as String
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func configureLabelsInCell() {
        addSubviews(currencyName, currencyCode, currencyRate)
        setTranslatingOfAutoresizingMaskIntoConstraintsToFalseForViews(currencyName, currencyCode, currencyRate)
        
        currencyName.frame.size = CGSize(width: frame.size.width * 0.65,
                                         height: frame.size.height * 0.5)
        currencyName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIElementsScaleSizes.currencyNameLabelLeadingSpace).isActive = true
        currencyName.topAnchor.constraint(equalTo: topAnchor, constant: UIElementsScaleSizes.currencyNameLabelTopSpace).isActive = true
        currencyName.textAlignment = .left
        currencyName.font = .systemFont(ofSize: currencyName.frame.height * UIElementsScaleSizes.currencyAndCodeLabelsFontScaleSize)

        currencyCode.frame.size = CGSize(width: frame.size.width * 0.65,
                                         height: frame.size.height * 0.5)
        currencyCode.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIElementsScaleSizes.currencyCodeLabelLeadingSpace).isActive = true
        currencyCode.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIElementsScaleSizes.currencyCodeLabelBottomSpace).isActive = true
        currencyCode.textAlignment = .left
        currencyCode.font = .systemFont(ofSize: currencyCode.frame.height * UIElementsScaleSizes.currencyAndCodeLabelsFontScaleSize)
    
        currencyRate.frame.size = CGSize(width: frame.size.width * 0.25,
                                         height: frame.size.height)
        currencyRate.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIElementsScaleSizes.currencyRateLabelLeadingSpace).isActive = true
        currencyRate.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        currencyRate.textAlignment = .right
        currencyRate.font = .systemFont(ofSize: currencyRate.frame.height * UIElementsScaleSizes.currencyRateLabelFontScaleSize)
    }
}
