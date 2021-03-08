//
//  Items.swift
//  Minders
//
//  Created by Arthur Roolfs on 10/31/19.
//  Copyright © 2019 Arthur Roolfs. All rights reserved.
//

import Foundation

class PurchasedExchange: Codable {
    
    let exchangeRatesApiUrl = "https://api.exchangeratesapi.io/latest"
    let currencyCode = "USD"

    
    var items = [PurchasedExchangeItem]()
    var sorted_items = [PurchasedExchangeItem]()
    
    

   
    // MARK: - Utilty

    func add(code: String, amount: String, time: String) {
        let purchasedExchangeItem = PurchasedExchangeItem(code: code, amount: amount,
                                    date: time,
                                    uid: UUID())
        items.insert(purchasedExchangeItem, at: 0)
    }
    
    /*
    func loadRequest() {
        print("call load request")
        fetchRates() { result in
            switch result {
                case let .Success(exchange):
                    //OperationQueue.main.addOperation() {
                        let now = Date()
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "MM-dd-yy HH:mm:ss"
                        let dateString = dateFormatter.string(from: now)
                        
                        if let rates = exchange.rates {
                            self.items = [PurchasedExchangeItem]()
                            self.sorted_items = [PurchasedExchangeItem]()
                            
                            for (code,price) in rates{
                                self.add(code: code, currency_value: String(price), time:dateString)
                            }
                            
                            self.sorted_items = self.items.sorted{
                                $0.code > $1.code
                            }
                            
                            print("number of rows \(exchange.rates?.count ?? 0)")
                           FileManager.default.saveExchangeRates(exchangeRates: self)
//                        }
                        /*
                        self.array_keys_unsorted = Array((self.exchangeInfo?.rates?.keys)! )

                        self.array_keys_sorted = self.array_keys_unsorted?.sorted()

                        self.array_values = Array((self.exchangeInfo?.rates?.values)! )
                        */


                        //self.tableView.reloadData()
                        }
                //}
                case let .Failure(error):
                    print("Error: \(error)")
            }
        }
    }
   

    
    func loadRequest() {
            print("call load request")
            fetchRates() { result in
                switch result {
                    case let .Success(exchange):
                        //OperationQueue.main.addOperation() {
                            let now = Date()
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "MM-dd-yy HH:mm:ss"
                            let dateString = dateFormatter.string(from: now)
                            
                            if let rates = exchange.rates {
                                self.items = [PurchasedExchangeItem]()
                                self.sorted_items = [PurchasedExchangeItem]()
                                
                                for (code,price) in rates{
                                    //self.add(code: code, currency_value: String(price), time:dateString)
                                }
                                
                                self.sorted_items = self.items.sorted{
                                    $0.code > $1.code
                                }
                                
                                print("number of rows \(exchange.rates?.count ?? 0)")
                                FileManager.default.saveExchangeRates(purchasedExchange: self)
    //                        }
                            /*
                            self.array_keys_unsorted = Array((self.exchangeInfo?.rates?.keys)! )

                            self.array_keys_sorted = self.array_keys_unsorted?.sorted()

                            self.array_values = Array((self.exchangeInfo?.rates?.values)! )
                            */


                            //self.tableView.reloadData()
                            }
                    //}
                    case let .Failure(error):
                        print("Error: \(error)")
                }
            }
        }
        
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
     */
    /*
    func move(fromIndex: Int, toIndex: Int) {
        if fromIndex != toIndex {
            let item = items[fromIndex]
            items.remove(at: fromIndex)
            items.insert(item, at: toIndex)
        }
    }
    
    
    func removeItem(at index: Int) {
        if let _ = items[index] as MinderItem? {
            items.remove(at: index)
        }
    }
     */
}

