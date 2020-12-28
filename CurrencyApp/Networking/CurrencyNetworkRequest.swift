//
//  CurrencyNetworkRequest.swift
//  CurrencyApp
//
//  Created by Maksym Teslia on 23.12.2020.
//  Copyright © 2020 Maksym Teslia. All rights reserved.
//

import Foundation

fileprivate struct Constants {
    static let urlString = "https://bank.gov.ua/NBUStatService/v1/statdirectory/exchange?json"
}

enum CurrencyError: Error {
    case noUrlAvailable, noDataAvailable, canNotProcessData
}

struct CurrencyRequest {
    let resourceURL = URL(string: Constants.urlString)
    
    func getCurrencyInformation(completion:@escaping(Result<[CurrencyInfo], CurrencyError>) -> Void ) {
        guard let validUrl = resourceURL else {
            completion(.failure(.noUrlAvailable))
            return
        }
        let dataTask = URLSession.shared.dataTask(with: validUrl) { data, _, error in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do {
                let decoder = JSONDecoder()
                let currencyResponse = try decoder.decode([CurrencyInfo].self, from: jsonData)
                let currencyDetails = currencyResponse
                completion(.success(currencyDetails))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
}
