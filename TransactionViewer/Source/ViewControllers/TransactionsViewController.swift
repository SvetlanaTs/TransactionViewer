//
//  TransactionsViewController.swift
//  TransactionViewer
//
//  Created by Svetlana T on 03.02.18.
//  Copyright © 2018 Svetlana T. All rights reserved.
//

import UIKit

class TransactionsViewController: UIViewController {

    var sku: String?
    var transactions: [Transaction]?
    var rates = RateParser.rates
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let sku = sku else { fatalError() }
        navigationItem.title = "Transactions for \(sku)"
        tableView.register(UINib.init(nibName: ProductCell.identifier, bundle: nil), forCellReuseIdentifier: ProductCell.identifier)
    }

}

extension TransactionsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let transactions = transactions else { fatalError() }
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.identifier, for: indexPath) as! ProductCell
        
        guard let transactions = transactions else { fatalError() }
        let coeff = coefficient(of: transactions[indexPath.row])
        let amount = transactions[indexPath.row].amount
        let currency = convertSymbol(from: transactions[indexPath.row].currency)
        let GBP = convertSymbol(from: "GBP")

        cell.mainLabel.text = currency + amount
        cell.infoLabel.text = "\(GBP)\((amount as NSString).doubleValue * coeff)"
        
        return cell
    }
    
}

extension TransactionsViewController {
    
    func convertSymbol(from currency: String) -> String {
        switch currency {
        case "USD":
            return "$"
        case "GBP":
            return "£"
        case "CAD":
            return "CA$"
        case "AUD":
            return "A$"
        default:
            return "£"
        }
    }
    
    func coefficient(of transaction: Transaction) -> Double {
        
        for rate in rates {
            if transaction.currency == "AUD" && rate.conversion == .AUD_to_GBP {
                return (rate.rate as NSString).doubleValue
            }
            
            if transaction.currency == "CAD" && rate.conversion == .CAD_to_GBP {
                return (rate.rate as NSString).doubleValue
            }

            if transaction.currency == "USD" && rate.conversion == .USD_to_GBP {
                return (rate.rate as NSString).doubleValue
            }

        }

        return 1.0
    }
    
}
