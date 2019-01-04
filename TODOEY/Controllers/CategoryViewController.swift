//
//  CategoryViewController.swift
//  TODOEY
//
//  Created by ahmed on 1/2/19.
//  Copyright © 2019 ahmed. All rights reserved.
//

import UIKit
import RealmSwift
class CategoryViewController: UITableViewController {

    let realm = try! Realm()
    
    var categories :Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories added yet"
        return cell
    }
    
    
   

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add Category", message: "", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Create New Category"

        }
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
            
            let newCategory = Category()
            newCategory.name = alert.textFields![0].text!
            self.saveData(category: newCategory)
            
            
        }))
        present(alert, animated: true, completion: nil)
        
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         let desination = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            desination.selectedCategory = categories?[indexPath.row]
        }
        
        
    }
    
    
    func loadData(){
        
         categories = realm.objects(Category.self)
        
        tableView.reloadData()
    
    }
    
    
    func saveData(category : Category){
        
        do{
            try realm.write {
                realm.add(category)
            }

        }catch{
            print("error saving")
        }
        self.tableView.reloadData()

    }
}
