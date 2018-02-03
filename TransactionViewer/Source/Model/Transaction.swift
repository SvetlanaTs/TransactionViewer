//
//  Transaction.swift
//  TransactionViewer
//
//  Created by Svetlana T on 03.02.18.
//  Copyright © 2018 Svetlana T. All rights reserved.
//

import Foundation

class Transaction {

    fileprivate struct Keys {
        static var amountKey = "amount"
        static var currencyKey = "currency"
        static var skuKey = "sku"
    }

    var amount: String
    var currency: String
    var sku: String
    
    init(info: [String : String]) {
        self.amount = info[Keys.amountKey] ?? ""
        self.currency = info[Keys.currencyKey] ?? ""
        self.sku = info[Keys.skuKey] ?? ""
    }
    
}

class TransactionParser {
    
    static var transactions: Dictionary<String, [Transaction]> = TransactionParser.loadTransactions()
    
    fileprivate class func loadTransactions() -> Dictionary<String, [Transaction]> {
        var transactions = [Transaction]()
        let array = NSArray(contentsOfFile: Bundle.main.path(forResource: "transactions", ofType: "plist")!)!
        
        for dict in array as! [[String : String]] {
            let entity = Transaction(info: dict)
            transactions.append(entity)
        }
        
        let resultDict = groupIntoDictionary(transactions)
        
        return resultDict
    }
    
    fileprivate class func groupIntoDictionary(_ transactions: [Transaction]) -> Dictionary<String, [Transaction]> {
        let predicate = { (element: Transaction) in
            return element.sku
        }
        
        return Dictionary(grouping: transactions, by: predicate)
    }
    
}
