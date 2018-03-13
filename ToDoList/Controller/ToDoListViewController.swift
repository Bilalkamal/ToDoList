//
//  ViewController.swift
//  ToDoList
//
//  Created by Bilal on 2018-03-12.
//  Copyright © 2018 Bilal Kamal Co. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = [Item]()
    var defaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       let newItem = Item()
        newItem.title = "Find Mike's Phone"
        itemArray.append(newItem)
       
        let newItem2 = Item()
        newItem2.title = "Find Bilal's Phone"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Find Jacob's  Phone"
        itemArray.append(newItem3)
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item]{
            itemArray = items
        }
        
    }
    
    //MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    // MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happen when the user adds the new item
            
            let newItem = Item()
            newItem.title = textField.text!
            
            
            self.itemArray.append(newItem )
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        alert.addAction(action)
        present(alert,animated: true, completion: nil)
    }
    
}

