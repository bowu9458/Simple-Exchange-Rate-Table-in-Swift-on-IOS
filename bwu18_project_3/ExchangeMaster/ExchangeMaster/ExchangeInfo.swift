//
//  ExchangeInfo.swift
//  Webster
//
//  Created by Arthur Roolfs on 11/11/19.
//  Copyright © 2019 Arthur Roolfs. All rights reserved.
//

import Foundation


struct ExchangeInfo: Decodable {
      
    var base: String?
    var date: String?
    var rates: [String:Double]?
}
