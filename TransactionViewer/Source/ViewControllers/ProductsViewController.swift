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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for (key, values) in transactions {
            print(key)
            print(values.count)
        }
        keys = Array(transactions.keys.map{ $0 })
        values = Array(transactions.values.map{ $0 })
        
        tableView.register(UINib.init(nibName: ProductCell.identifier, bundle: nil), forCellReuseIdentifier: ProductCell.identifier)
        
//        tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.identifier)
    }

}

extension ProductsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.identifier, for: indexPath) as! ProductCell
        
        print("*** \(keys[indexPath.row])")
        print("\(values[indexPath.row].count) operations")
        cell.SKULabel.text = "\(keys[indexPath.row])"
        cell.infoLabel.text = "\(values[indexPath.row].count) operations"
        
        return cell
    }
    
}
