//
//  CurrencyConverterViewData.swift
//  CurrencyApp
//
//  Created by Maksym Teslia on 26.12.2020.
//  Copyright © 2020 Maksym Teslia. All rights reserved.
//

import Foundation

fileprivate struct nonMoneyIDs {
    static let goldId = 959
    static let silverId = 961
    static let platinumId = 962
    static let palladiumId = 964
    static let specialLoaningRights = 960
}

fileprivate struct commonMoneyUnitsIDs {
    static let poundID = 826
    static let americanDollarID = 840
    static let euroID = 978
    static let zlotyID = 985
    static let swissFrankID = 756
    static let shekelID = 376
    static let rubleID = 643
}

class CurrencyConverterInfoViewData {
    weak var delegate: CurrencyConverterViewDataDelegate?
    var commonMoneyCurrencies = [CurrencyInfo]()
    var otherMoneyCurrencies = [CurrencyInfo]()
    var allPreciousMetalsCurrencies = [CurrencyInfo]()
    var allMoneyCurrencies = [CurrencyInfo]()
    var firstCurrencyPickerChosenValue: Double?
    var secondCurrencyPickerChosenValue: Double?
    var firstPreciousMetalsPickerChosenValue: Double?
    var secondPreciousMetalsPickerChosenValue: Double?
    
    init(delegate: CurrencyConverterViewDataDelegate,
         commonMoneyCurrencies: [CurrencyInfo],
         otherMoneyCurrencies: [CurrencyInfo],
         allPreciousMetalsCurrencies: [CurrencyInfo]) {
        self.delegate = delegate
        self.commonMoneyCurrencies = commonMoneyCurrencies
        self.otherMoneyCurrencies = otherMoneyCurrencies
        self.allPreciousMetalsCurrencies = allPreciousMetalsCurrencies
        //the array is created to put the common currency to the top of each picker
        allMoneyCurrencies = commonMoneyCurrencies + otherMoneyCurrencies

        firstCurrencyPickerChosenValue = allMoneyCurrencies[0].rate
        secondCurrencyPickerChosenValue = allMoneyCurrencies[0].rate
        firstPreciousMetalsPickerChosenValue = allMoneyCurrencies[0].rate
        secondPreciousMetalsPickerChosenValue = allPreciousMetalsCurrencies[0].rate
    }
    
    func getOutputValueFor(userInputFromTextView userInput: String, isFirst: Bool, isMetal: Bool) -> String {
        guard let firstPickerValue = isMetal ? firstPreciousMetalsPickerChosenValue : firstCurrencyPickerChosenValue,
            let secondPickerValue = isMetal ? secondPreciousMetalsPickerChosenValue : secondCurrencyPickerChosenValue else { return "" }
        
        var valueTypedByTheUser: Double
        if userInput.isEmpty {
            valueTypedByTheUser = 0
        } else if let value = Double(userInput) {
            valueTypedByTheUser = value
        } else {
            return ""
        }
        
        let output = isFirst ?
            firstPickerValue / secondPickerValue * valueTypedByTheUser :
            secondPickerValue / firstPickerValue * valueTypedByTheUser
        return NSString(format: "%.2f", output) as String
    }
}
