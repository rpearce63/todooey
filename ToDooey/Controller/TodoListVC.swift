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
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
    }

    
    // MARK: View Actions
    func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(self.todoItemsArray)
            try data.write(to: self.dataFilePath!)
        } catch {
            print(error)
        }
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                todoItemsArray = try decoder.decode([Item].self, from: data)
            } catch {
                print(error)
            }
        }
    }
    
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        
        var newItemTextField  = UITextField()
        
        let addItemAlert = UIAlertController(title: "Add a New Item", message: "", preferredStyle: .alert)
        
        addItemAlert.addTextField { (itemTextField) in
            itemTextField.placeholder = "create new item"
            newItemTextField = itemTextField
        }
        
        let addAction = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = Item()
            newItem.title = newItemTextField.text!
            self.todoItemsArray.append(newItem)
            
            self.saveItems()
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
        saveItems()
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

