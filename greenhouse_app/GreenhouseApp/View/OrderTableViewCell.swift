//
//  TableViewCell.swift
//  GreenhouseApp
//
//  Created by Elizaveta on 6/2/19.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet var oName: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var oPrice: UILabel!
    @IBOutlet var count: UILabel!
    @IBOutlet var oCount: UILabel!
    
    @IBOutlet weak var stepper: UIStepper!
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        count.text = Int(sender.value).description
    }
}
