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

    var todoItems : Results<Item>?
    let realm = try! Realm()
    
    
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundView = setGradientBackground()
        //print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }

    func setGradientBackground() -> UIView {
        let view = UIView()
        view.frame = tableView.bounds
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.blue.cgColor, UIColor.cyan.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = tableView.bounds
        
        view.layer.addSublayer(gradientLayer)
        return view
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
        
        return cell
    }
    
    
    // MARK: TableView Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //todoItems[indexPath.row].done = !todoItems[indexPath.row].done
        
        //saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
}

//MARK: Search bar methods

//extension TodoListVC: UISearchBarDelegate {
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text! )
//
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//        loadItems(with: request, predicate: predicate)
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text == "" {
//            loadItems()
//
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//
//        }
//    }
//
//}












