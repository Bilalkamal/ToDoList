//
//  ViewController.swift
//  ToDoList
//
//  Created by Bilal on 2018-03-12.
//  Copyright © 2018 Bilal Kamal Co. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController {

    var todoItems : Results<Item>?
    
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        loadItems()
        
    }
    
    //MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            
            cell.accessoryType = item.done ? .checkmark : .none
        }else {
            cell.textLabel?.text = ""

        }
        
        
        
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
//                    realm.delete(item)
                    item.done = !item.done
                }
            }catch{
                print(error)
            }
            
        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    // MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happen when the user adds the new item
            
            
          
            if let currentCategory = self.selectedCategory{
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        currentCategory.items.append(newItem)
                    }
                }catch{
                    print(error)
                }
               
            }
            
           self.tableView.reloadData()
           

            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        alert.addAction(action)
        present(alert,animated: true, completion: nil)
    }
    //MARK: - Model Manipulation Methods
    

    
    func loadItems(){

        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
}

//MARK: - Search Bar Methods
//extension ToDoListViewController: UISearchBarDelegate {
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//       loadItems(with: request, predicate: predicate)
//
//    }
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text!.count == 0{
//            loadItems()
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//
//
//        }
//    }


}
