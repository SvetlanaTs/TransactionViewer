//
//  ProductsViewController.swift
//  TransactionViewer
//
//  Created by Svetlana T on 03.02.18.
//  Copyright © 2018 Svetlana T. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var transactions: Dictionary<String, [Transaction]> = TransactionParser.transactions
    var keys = [String]()
    var values = [[Transaction]]()
    var selectedRow = 0
    
    let SEGUE_ID = "SEGUE_ID"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        keys = Array(transactions.keys.map{ $0 })
        values = Array(transactions.values.map{ $0 })
        
        tableView.register(UINib.init(nibName: ProductCell.identifier, bundle: nil), forCellReuseIdentifier: ProductCell.identifier)
    }

}

extension ProductsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.identifier, for: indexPath) as! ProductCell
        cell.accessoryType = .disclosureIndicator
        
        cell.mainLabel.text = "\(keys[indexPath.row])"
        cell.infoLabel.text = "\(values[indexPath.row].count) operations"
        
        return cell
    }
    
}

extension ProductsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedRow = indexPath.row
        performSegue(withIdentifier: SEGUE_ID, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationController = segue.destination as! TransactionsViewController
        destinationController.sku = keys[selectedRow]
        destinationController.transactions = values[selectedRow]
    }
    
}
