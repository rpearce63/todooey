//
//  ViewController.swift
//  ToDooey
//
//  Created by Rick on 4/21/18.
//  Copyright © 2018 Pearce. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListVC: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    var tableViewHeaderView : UIView?
    
    var todoItems : Results<Item>?
    lazy var realm = try! Realm()
    
    
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.backgroundView = view.setGradientBackground()
        tableViewHeaderView = self.tableView.tableHeaderView
        //print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }

    
    // MARK: View Actions
    
    func loadItems() {
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
    
        tableView.reloadData()
    }
    
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        
        var newItemTextField  = UITextField()
        
        let addItemAlert = UIAlertController(title: "Add a New Item", message: "", preferredStyle: .alert)
        
        addItemAlert.addTextField { (itemTextField) in
            itemTextField.placeholder = "create new item"
            newItemTextField = itemTextField
        }
        
        let addAction = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = newItemTextField.text!
                        //newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                
                } catch {
                    print(error)
                }
            }
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
        let count = todoItems?.count ?? 1
        return count > 0 ? count : 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoItemCell", for: indexPath)
        let count = todoItems?.count ?? 0
        if count > 0 {
            let item = todoItems![indexPath.row]
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Items Added"
        }
        //cell.textLabel?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        if count == 0 {
            self.tableView.tableHeaderView = nil
        } else {
            self.tableView.tableHeaderView = tableViewHeaderView
        }
        return cell
    }
    
    
    // MARK: TableView Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                }
            } catch {
                print(error)
            }
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            do {
                try realm.write {
                    realm.delete(todoItems![indexPath.row])
                }
            } catch {
                print(error)
            }
            tableView.reloadData()
        }
    }
    
}

//MARK: Search bar methods

extension TodoListVC: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()

    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }

        }
    }

}












