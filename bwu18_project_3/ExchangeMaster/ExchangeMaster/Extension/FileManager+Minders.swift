//
//   FileManager+Minders.swift
//   Minders
//
//  Created by: Arthur Roolfs on 7/15/20.
//  Copyright © 2020 Arthur Roolfs. All rights reserved.
//

import Foundation


let kPurchasedExchangeFile = "PurchasedExchangeFile"

extension FileManager {
    
    func getExchangeRates() -> PurchasedExchange {
                
       if let url = urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(kPurchasedExchangeFile, isDirectory: false) {
            
           
        
            if let jsondata = contents(atPath: url.path) {
                let decoder = JSONDecoder()
                do {
                    let model = try decoder.decode(PurchasedExchange.self, from: jsondata)
                    
                    return model
                } catch { fatalError(error.localizedDescription) }
            }
        }
        return PurchasedExchange()
    }
    
    func saveExchangeRates(purchasedExchange: PurchasedExchange) {
        
        if let url = urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(kPurchasedExchangeFile, isDirectory: false) {
            
            /*
            do {
                try removeItem(at: url)
            } catch { fatalError(error.localizedDescription) }
            */
            
            if fileExists(atPath: url.path) {
                do {
                    try removeItem(at: url)
                } catch { fatalError(error.localizedDescription) }
            }
            
            if let encodedData = try? JSONEncoder().encode(purchasedExchange) {
                createFile(atPath: url.path, contents: encodedData, attributes: nil)
            } else {
                fatalError("Couldn't write data!")
            }
        }
    }
}

