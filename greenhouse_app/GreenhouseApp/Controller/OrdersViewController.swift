//
//  OrdersViewController.swift
//  GreenhouseApp
//
//  Created by Elizaveta on 6/2/19.
//

import UIKit
import CoreData

class OrdersViewController: UIViewController, UITableViewDataSource {

    @IBOutlet var table: UITableView!
    @IBOutlet var costLabel: UILabel!
    
    var compositions = [NSManagedObject]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func orderButtonClicked(_ sender: Any) {
        DispatchQueue.main.async
            {
                let alert = UIAlertController(title: "Make order", message: "We will contact you within 15 minutes", preferredStyle: .alert)
                alert.addTextField(configurationHandler: {(textField) in
                    textField.placeholder = "Enter phone number"
                })
                let alertAction = UIAlertAction(title: "OK", style: .default)
                {
                    (UIAlertAction) -> Void in
                }
                alert.addAction(alertAction)
                self.present(alert, animated: true)
                {
                    () -> Void in
                }
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print(compositions.count)
        return compositions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCellCart") as! OrderTableViewCell
        let comp = compositions[indexPath.row] as! Orders //choose if count != 0
        cell.name?.text = comp.flower_composition
        cell.price?.text = (String)(comp.cost)
        cell.count?.text = (String)(comp.amount)  //from prev table
        
        return cell
      
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ordersSegue" || segue.identifier == "cartSegue")
        {
            let vc = segue.destination as! OrdersViewController
            vc.compositions = sender as! [NSManagedObject]
            vc.table.reloadData()
        }
    }
}
