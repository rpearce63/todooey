//
//  CategoryVC.swift
//  ToDooey
//
//  Created by Rick on 4/22/18.
//  Copyright © 2018 Pearce. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryVC: UITableViewController {

    lazy var realm = try! Realm()
    
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var categories : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.tableView.backgroundView = view.setGradientBackground()
    }
    
    //MARK: - Tableview Datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = categories?.count ?? 1
        return count == 0 ? 1 : count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        let count = categories?.count ?? 1
        cell.textLabel?.text = count > 0 ? categories?[indexPath.row].name : "No Categories Added Yet"
        cell.backgroundColor = view.getRandomColor()
        return cell
    }
    
    //MARK: - Data Manipulation methods
    func loadData() {
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    func saveData(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print(error)
        }
        tableView.reloadData()
    }
    
    //MARK: - Add New Category
    
    @IBAction func addBtnPressed(_ sender: Any) {
        
        let alert = UIAlertController(title: "New Category", message: "", preferredStyle: .alert)
        
        var alertTextField = UITextField()
        
        alert.addTextField { (textField) in
            textField.placeholder = "enter new category"
            alertTextField = textField
        }
        
        let saveAction = UIAlertAction(title: "Add", style: .default) { (action) in
            let newCategory = Category()
            newCategory.name = alertTextField.text!
            
            self.saveData(category: newCategory)
        }
        
        alert.addAction(saveAction)
        
        present(alert, animated: true, completion: nil)
    }
   
    
    //MARK - Tableview Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListVC
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories![indexPath.row]
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            do {
               try realm.write {
                    realm.delete(categories![indexPath.row])
                }
            } catch {
                print(error)
            }
        }
        tableView.reloadData()
    }
    
    
}
