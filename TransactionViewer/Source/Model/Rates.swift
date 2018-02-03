//
//  Rates.swift
//  TransactionViewer
//
//  Created by Svetlana T on 03.02.18.
//  Copyright © 2018 Svetlana T. All rights reserved.
//

import Foundation

class Rate {
    
    enum ConversionType {
        case USD_to_GBP
        case CAD_to_GBP
        case AUD_to_GBP
        case GBP_to_GBP
        case noConversion
    }
    
    fileprivate struct Keys {
        static var fromKey = "from"
        static var rateKey = "rate"
        static var toKey = "to"
    }
    
    var from: String
    var rate: String
    var to: String
    var conversion: ConversionType
    
    init(info: [String : String]) {
        self.from = info[Keys.fromKey] ?? ""
        self.rate = info[Keys.rateKey] ?? ""
        self.to = info[Keys.toKey] ?? ""
        self.conversion = .noConversion
    }
    
}

class RateParser {
    
    static var rates: [Rate] = RateParser.loadRates()
    
    fileprivate class func loadRates() -> [Rate] {
        var rates = [Rate]()
        let array = NSArray(contentsOfFile: Bundle.main.path(forResource: "rates", ofType: "plist")!)!
        
        for dict in array as! [[String : String]] {
            let entity = Rate(info: dict)
            
            if entity.from == "USD" && entity.to == "GBP" { entity.conversion = .USD_to_GBP }
            if entity.from == "AUD" && entity.to == "GBP" { entity.conversion = .AUD_to_GBP }
            if entity.from == "CAD" && entity.to == "GBP" { entity.conversion = .CAD_to_GBP }
            if entity.from == "GBP" && entity.to == "GBP" { entity.conversion = .GBP_to_GBP }

            rates.append(entity)
        }
        
        return rates
    }
        
}
