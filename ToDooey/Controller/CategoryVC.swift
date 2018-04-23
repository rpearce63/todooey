//
//  CategoryVC.swift
//  ToDooey
//
//  Created by Rick on 4/22/18.
//  Copyright © 2018 Pearce. All rights reserved.
//

import UIKit
import CoreData

class CategoryVC: UITableViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var categories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    //MARK: - Tableview Datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }
    
    //MARK: - Data Manipulation methods
    func loadData() {
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        do {
            categories = try context.fetch(request) 
        } catch {
            print(error)
        }
        tableView.reloadData()
    }
    
    func saveData() {
        do {
            try context.save()
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
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { (action) in
            let newCategory = Category(context: self.context)
            newCategory.name = alertTextField.text!
            self.categories.append(newCategory)
            self.saveData()
        }
        
        alert.addAction(saveAction)
        
        present(alert, animated: true, completion: nil)
    }
   
    
    //MARK - Tableview Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! TodoListVC
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destination.selectedCategory = categories[indexPath.row]
        }
    }
    
    
    
}
