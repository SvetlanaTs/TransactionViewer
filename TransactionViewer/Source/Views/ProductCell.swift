//
//  ProductCell.swift
//  TransactionViewer
//
//  Created by Svetlana T on 03.02.18.
//  Copyright © 2018 Svetlana T. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {
    
    @IBOutlet weak var SKULabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }


    static var identifier: String {
        return String(describing: self)
    }


}
