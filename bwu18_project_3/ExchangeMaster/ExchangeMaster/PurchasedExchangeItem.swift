//
//   MinderItem.swift
//   Minders
//
//  Created by: Arthur Roolfs on 11/4/19.
//  Copyright © 2019 Arthur Roolfs. All rights reserved.
//

import Foundation



struct PurchasedExchangeItem: Equatable, Codable {
    var code: String
    var amount: String
    var date: String
    var uid: UUID
}

