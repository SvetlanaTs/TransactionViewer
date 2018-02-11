//
//  TransactionsViewController.swift
//  TransactionViewer
//
//  Created by Svetlana T on 03.02.18.
//  Copyright © 2018 Svetlana T. All rights reserved.
//

import UIKit

class TransactionsViewController: UIViewController {

    var sku = ""
    var transactions = [Transaction]()

    var rates = RateParser.rates
    var info: (String, [Transaction])?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let info = info else { fatalError() }
        sku = info.0
        transactions = info.1

        navigationItem.title = "Transactions for \(sku)"
    }

}

extension TransactionsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.identifier, for: indexPath) as! ProductCell
        
        let coeff = coefficient(of: transactions[indexPath.row])
        let amount = transactions[indexPath.row].amount
        let currency = convertSymbol(from: transactions[indexPath.row].currency)
        let GBP = convertSymbol(from: "GBP")

        cell.mainLabel.text = currency + amount
        cell.infoLabel.text = "\(GBP)\((amount as NSString).doubleValue * coeff)"
        
        return cell
    }
    
}

extension TransactionsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return totalSum()
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
    
    func totalSum() -> String {
        var sum = 0.0

        for transaction in transactions {
            let coeff = coefficient(of: transaction)
            sum += (transaction.amount as NSString).doubleValue * coeff
        }
        
        return "Total: £\(sum)"
    }
    
}
