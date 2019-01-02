//
//  CategoryViewController.swift
//  TODOEY
//
//  Created by ahmed on 1/2/19.
//  Copyright © 2019 ahmed. All rights reserved.
//

import UIKit
import CoreData
class CategoryViewController: UITableViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var categories = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = categories[indexPath.row]
        cell.textLabel?.text = category.name
        return cell
    }
    
    
   

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add Category", message: "", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Create New Category"

        }
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
            
            let newCategory = Category(context: self.context)
            newCategory.name = alert.textFields![0].text
            self.categories.append(newCategory)
            self.saveData()
            
            
        }))
        present(alert, animated: true, completion: nil)
        
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         let desination = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            desination.selectedCategory = categories[indexPath.row]
        }
        
        
    }
    
    
    func loadData(request : NSFetchRequest<Category> = Category.fetchRequest()){
        
        do{
            categories = try context.fetch(request)
        }catch{
            print("error while fetching Data \(error)")
        }
    }
    
    
    func saveData(){
        
        do{
            try context.save()

        }catch{
            print("error saving")
        }
        self.tableView.reloadData()

    }
}
