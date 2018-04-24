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
        self.tableView.backgroundView = view.setGradientBackground()
    }
    
    //MARK: - Tableview Datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added Yet"
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
    
    
    
}
