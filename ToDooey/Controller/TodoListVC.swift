//
//  ViewController.swift
//  ToDooey
//
//  Created by Rick on 4/21/18.
//  Copyright © 2018 Pearce. All rights reserved.
//

import UIKit

class TodoListVC: UITableViewController {

    var todoItemsArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var newItem = Item()
        newItem.title = "Find Mike"
        todoItemsArray.append(newItem)
        
        var newItem2 = Item()
        newItem2.title = "Buy Eggos"
        todoItemsArray.append(newItem2)
        
        var newItem3 = Item()
        newItem3.title = "Destroy Demogorgon"
        todoItemsArray.append(newItem3)
        
        if let items = UserDefaults.standard.array(forKey: "TodoListArray") as? [Item] {
            todoItemsArray = items
        }
        
    }

    
    // MARK: View Actions
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        
        var newItemTextField  = UITextField()
        
        let addItemAlert = UIAlertController(title: "Add a New Item", message: "", preferredStyle: .alert)
        
        addItemAlert.addTextField { (itemTextField) in
            itemTextField.placeholder = "create new item"
            newItemTextField = itemTextField
        }
        
        let addAction = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            var newItem = Item()
            newItem.title = newItemTextField.text!
            self.todoItemsArray.append(newItem)
            
            self.defaults.set(self.todoItemsArray, forKey: "TodoListArray")
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
            addItemAlert.dismiss(animated: true, completion: nil)
        }
        
        addItemAlert.addAction(cancelAction)
        addItemAlert.addAction(addAction)
        
        
        present(addItemAlert, animated: true, completion: nil)
    }
    

    // MARK: - TableView data methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItemsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoItemCell", for: indexPath)
        
        cell.textLabel?.text = todoItemsArray[indexPath.row].title
        cell.accessoryType = todoItemsArray[indexPath.row].done ? .checkmark : .none
        
        return cell
    }
    
    
    // MARK: TableView Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        todoItemsArray[indexPath.row].done = !todoItemsArray[indexPath.row].done

        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

