//
//  SaleHistoryTableViewCell.swift
//  Home Report
//
//  Created by Andi Setiyadi on 6/8/18.
//  Copyright © 2018 devhubs. All rights reserved.
//

import UIKit

class SaleHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var soldDateLabel: UILabel!
    @IBOutlet weak var soldPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(saleHistory: SaleHistory) {
        soldDateLabel.text = (saleHistory.soldDate as Date?)?.toString
        soldPriceLabel.text = saleHistory.soldPrice.currencyFormatter
    }

}
