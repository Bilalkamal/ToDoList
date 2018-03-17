//
//  CategoryViewController.swift
//  ToDoList
//
//  Created by Bilal on 2018-03-14.
//  Copyright © 2018 Bilal Kamal Co. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework


class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    var categories : Results <Category>?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadCategories()
        tableView.rowHeight = 80.0
        tableView.separatorStyle = .none
        
    }

    
    // MARK: - Table view data source

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
       return categories?.count ?? 1
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

         let cell = super.tableView(tableView, cellForRowAt : indexPath)
            cell.textLabel?.text = categories?[indexPath.row].name ?? ""
            cell.backgroundColor = UIColor(hexString: (categories?[indexPath.row].color) ?? "1D9BF6") 
        
       
        
        
        return cell
    }
    
    // MARK: - Table view Delegate Methods
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        performSegue(withIdentifier: "goToItems", sender: self)
        

        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if  let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        
        
        }
        
    }
    
    
    
    // MARK: - Table Data Manipulation Methods
    
    func saveCategories(category : Category){
        
        do{
            try realm.write {
                realm.add(category)
            }
            
            
        }catch{
            print(error)
        }
        
        
        self.tableView.reloadData()
    }
    
    func loadCategories(){
        
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
    override func updateModel(at indexPath: IndexPath) {
        if let item = categories?[indexPath.row]{
            do{
                try self.realm.write {
                    self.realm.delete(item)
                }

            }catch{
                print(error)
            }
        }
    }

    
    

    
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            //What will happen when the user adds the new Category
            
            
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.color = UIColor.randomFlat.hexValue()

            self.saveCategories(category: newCategory)
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Category"
            textField = alertTextField
            
        }
        alert.addAction(action)
        present(alert,animated: true, completion: nil)
    }
    
}



