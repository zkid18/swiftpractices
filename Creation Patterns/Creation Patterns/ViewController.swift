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

    
    //MARK: Onject Template Pattern
    
    class Product {
        var name: String
        var description: String
        var price: Double
        var stock: Int
        
        init (name: String, description: String, price: Double, stock: Int) {
            self.name = name
            self.description = description
            self.price = price
            self.stock = stock
        }
        
        func calculateTax(rate: Double) -> Double {
            return self.price*rate
        }
        
        var stockValue: Double {
            get {
                return self.price * Double(self.stock)
            }
        }
    }
    
    
    var products = [
        
        Product(name: "Kayak", description: "A boat for one person", price: 275.0, stock: 10),
        Product(name: "Lifejacket", description: "Protective and fashionable", price: 48.95, stock: 14),
        Product(name: "Corner Flags", description: "Give your playing field a professional touch", price: 34.95, stock: 1),

    ]
    

    
    func calculateStockValue(productsArray:[Product]) -> Double {
        return productsArray.reduce(0, combine: {(total, product) -> Double in
            return total + product.stockValue
        })
    }
    
    

    @IBOutlet weak var totalStockLabel: UILabel!
    @IBOutlet weak var productTableView: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()
        displayStockLabel()
        
        print ("Sales tax for Kayak: \(calculateStockValue(products))")
        print ("Total value of stock: \(products[0].stockValue))")
        
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
            {(numbers, product) -> Int in return numbers + product.stock})

        totalStockLabel.text = "\(totalStock) Products in store"
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let product = products[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("ProductCell") as! ProductTableCell
        cell.productId = indexPath.row
        cell.productName.text = product.name
        cell.productDescription.text = product.description
        cell.productStepper.value = Double(product.price)
        cell.productTextFiled.text = String(product.stockValue)
        
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
                            products[id].stock = level
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









