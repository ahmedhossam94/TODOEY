//
//  CategoryViewController.swift
//  TODOEY
//
//  Created by ahmed on 1/2/19.
//  Copyright © 2019 ahmed. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit
import ChameleonFramework
class CategoryViewController: UITableViewController {

    let realm = try! Realm()
    
    var categories :Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 80.0
        tableView.separatorStyle = .none
        
        loadData()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! SwipeTableViewCell
        let color = categories?[indexPath.row].colorString ?? UIColor.randomFlat().hexValue()
        cell.delegate = self
        cell.backgroundColor = UIColor(hexString: color)
       cell.textLabel?.textColor = UIColor(contrastingBlackOrWhiteColorOn:UIColor(hexString: color), isFlat:true)
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
            newCategory.colorString = UIColor.randomFlat().hexValue()
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


extension CategoryViewController : SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in

            
            if let delectionCategory = self.categories?[indexPath.row]{
                do{
                   
                    try self.realm.write {
                        self.realm.delete(delectionCategory)
                    }
                }catch{
                    print("error while deleting")
                }
                tableView.reloadData()

            }
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "trash-icon")
        
        return [deleteAction]
    }
//    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
//        var options = SwipeTableOptions()
//        options.expansionStyle = SwipeExpansionStyle.destructive
//        options.transitionStyle = .border
//        return options
//        
//    }
    
 
    
}
