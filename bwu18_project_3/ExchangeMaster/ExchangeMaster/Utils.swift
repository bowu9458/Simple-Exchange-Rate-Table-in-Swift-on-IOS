//
//   Utils.swift
//   Webster
//
//  Created by: Arthur Roolfs on 11/12/19.
//  Copyright © 2019 Arthur Roolfs. All rights reserved.
//

import Foundation

enum URLError: Error {
    case BadURL
    case NotImplementedYet
}

let session: URLSession = {
    return URLSession(configuration: URLSessionConfiguration.default)
}()

extension NumberFormatter {
    
    func currency(with price: Double, code: String) -> String {
        usesGroupingSeparator = true
        numberStyle = .currency
        currencyCode = code
        return string(from: NSNumber(value: price)) ?? ""
    }
}
