//
//  ExchangeHelper.swift
//  Webster
//
//  Created by Arthur Roolfs on 11/11/19.
//  Copyright © 2019 Arthur Roolfs. All rights reserved.
//

import Foundation


enum ExchangeHelperResult: Error {
    case Success(ExchangeInfo)
    case Failure(Error)
}

class ExchangeHelper {
    
    // https://exchangeratesapi.io
    let exchangeRatesApiUrl = "https://api.exchangeratesapi.io/latest"
    let currencyCode = "USD"
    
    
  
    private func getRates(from data: Data) -> ExchangeHelperResult {
        do {
            let decoder = JSONDecoder()
            let exchange = try decoder.decode(ExchangeInfo.self, from: data)
            return .Success(exchange)
        } catch let error {
            return .Failure(error)
        }
    }
    
    func fetchRates(completion: @escaping (ExchangeHelperResult) -> Void) {
                
        if let url = URL(string: exchangeRatesApiUrl) {
            let request = URLRequest(url: url)
            
            let task = session.dataTask(with: request) { data, _, error in
                guard let exchangeData = data else {
                    if let err = error {
                        completion(.Failure(err))
                    }
                    return
                }
                completion(self.getRates(from: exchangeData))
            }
            task.resume()
        }
    }
}
