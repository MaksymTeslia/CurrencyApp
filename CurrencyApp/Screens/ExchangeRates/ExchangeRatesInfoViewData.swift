//
//  ExchangeRatesInfoViewData.swift
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

class ExchangeRatesInfoViewData {
    weak var delegate: ExchangeRatesInfoViewDataDelegate?
    let currencyRequest = CurrencyRequest()
    var commonMoneyCurrencies = [CurrencyInfo]()
    var aboutOtherMoneyCurrencies = [CurrencyInfo]()
    var aboutAllPreciousMetals = [CurrencyInfo]()
    
    init(delegate: ExchangeRatesInfoViewDataDelegate) {
        self.delegate = delegate
    }
    
    func getCurrencyInformation() {
        currencyRequest.getCurrencyInformation { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error): print(error)
            case .success(let currency):
                
                for currencyPoint in currency {
                    
                    //when using the switch below currency objects are being sorted into different arrays with common currency, as dollar, euro ect, other currency, which is not used frequently by average person and precious metals, as gold, silver ect.
                    
                    switch currencyPoint.identifier {
                    case nonMoneyIDs.goldId, nonMoneyIDs.silverId, nonMoneyIDs.platinumId, nonMoneyIDs.palladiumId:
                        self.aboutAllPreciousMetals.append(currencyPoint)
                        
                    //common currency is being sorted below
                    case commonMoneyUnitsIDs.poundID, commonMoneyUnitsIDs.americanDollarID, commonMoneyUnitsIDs.euroID, commonMoneyUnitsIDs.zlotyID, commonMoneyUnitsIDs.swissFrankID, commonMoneyUnitsIDs.shekelID, commonMoneyUnitsIDs.rubleID:
                        self.commonMoneyCurrencies.append(currencyPoint)
                        
                    //missing object with number 960, since "special loaning rights" are not related to any array we have and not used by an average person
                    case nonMoneyIDs.specialLoaningRights: continue
                        
                    //the default case is sending non-common currency to it's array
                    default:
                        self.aboutOtherMoneyCurrencies.append(currencyPoint)
                    }
                }
                self.delegate?.currencyDataDidFetch()
            }
        }
    }
}
