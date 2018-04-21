//
//  ViewController.swift
//  ToDooey
//
//  Created by Rick on 4/21/18.
//  Copyright © 2018 Pearce. All rights reserved.
//

import UIKit

class TodoListVC: UITableViewController {

    var todoItemsArray : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
            self.todoItemsArray.append(newItemTextField.text!)
            self.tableView.reloadData()
        }
        
        
        addItemAlert.addAction(addAction)
        
        present(addItemAlert, animated: true, completion: nil)
    }
    

    // MARK: - TableView data methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItemsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoItemCell", for: indexPath)
        
        cell.textLabel?.text = todoItemsArray[indexPath.row]
        
        return cell
    }
    
    
    // MARK: TableView Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
}

