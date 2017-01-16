//
//  ViewController.swift
//  Creation Patterns
//
//  Created by Даниил on 15.01.17.
//  Copyright © 2017 Даниил. All rights reserved.
//

import UIKit



class ProductTableCell: UITableViewCell {
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productStepper: UIStepper!
    @IBOutlet weak var productTextFiled: UITextField!
    
    var productId: Int?
    
}


class ViewController: UIViewController, UITableViewDataSource {

    var products = [
    
        ("Kayak", "A boat for one person", "Watersports", 275.0, 10),
        ("Lifejacket", "Protective and fashionable", "Watersports", 48.95, 14),
        ("Soccer Ball", "FIFA-approved size and weight", "Soccer", 19.5, 32),
        ("Corner Flags", "Give your playing field a professional touch",
            "Soccer", 34.95, 1),
        ("Stadium", "Flat-packed 35,000-seat stadium", "Soccer", 79500.0, 4),
        ("Thinking Cap", "Improve your brain efficiency by 75%", "Chess", 16.0, 8),
        ("Unsteady Chair", "Secretly give your opponent a disadvantage",
            "Chess", 29.95, 3),
        ("Human Chess Board", "A fun game for the family", "Chess", 75.0, 2),
        ("Bling-Bling King", "Gold-plated, diamond-studded King",
            "Chess", 1200.0, 4)
        
    ]
    
    @IBOutlet weak var totalStockLabel: UILabel!
    @IBOutlet weak var productTableView: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()
        displayStockLabel()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func displayStockLabel() {
        
        //one solution
        
//        var totalStock = 0
//        
//        for product in products {
//            totalStock += product.4
//        }
        
        //another solution. refactored
        
        let totalStock = products.reduce(0, combine:
            {(numbers, product) -> Int in return numbers + product.4})

        totalStockLabel.text = "\(totalStock) Products in store"
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let product = products[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("ProductCell") as! ProductTableCell
        cell.productId = indexPath.row
        cell.productName.text = product.0
        cell.productDescription.text = product.1
        cell.productStepper.value = Double(product.4)
        cell.productTextFiled.text = String(product.4)
        
        return cell
    }
    
    @IBAction func stockLevelDidChange(sender: AnyObject) {
        if var currentCell = sender as? UIView {
            while (true) {
                currentCell = currentCell.superview!
                if let cell = currentCell as? ProductTableCell {
                    if let id = cell.productId {
                        
                        var newStockLevel: Int?
                        
                        if let stepper = sender as? UIStepper {
                            newStockLevel = Int(stepper.value)
                        } else if let textField = sender as? UITextField {
                            if let newValue = textField.text {
                                newStockLevel = Int(newValue)
                            }
                        }
                        
                        if let level = newStockLevel {
                            products[id].4 = level
                            cell.productStepper.value = Double(level)
                            cell.productTextFiled.text = String(level)
                        }
                    }
                    
                    break
                        
                    }
                }
            displayStockLabel()
            }
    }
    
}









