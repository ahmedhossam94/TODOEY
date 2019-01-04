//
//  ViewController.swift
//  TODOEY
//
//  Created by ahmed on 12/31/18.
//  Copyright © 2018 ahmed. All rights reserved.
//

import UIKit
import RealmSwift
class ToDoListViewController: UITableViewController  {
   
    var todoItems :Results<Item>?
    let realm = try! Realm()
    var selectedCategory : Category?{
        didSet{
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        print(dataFilePath)

        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
      if  let item = todoItems?[indexPath.row]
      {
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ?  .checkmark : .none
        
      }else{
        cell.textLabel?.text = "No Items Added"
        }
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = todoItems?[indexPath.row]{
            do{
            try realm.write {
                item.done = !item.done

            }
            }catch{
                print(error)
            }
        }
        

        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        

    }
   
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title:"Add Todoey New Item" , message: "", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Create New Item"
        }
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let text = alert.textFields![0].text!
            if let currentCategory = self.selectedCategory{
                do{
                    try self.realm.write {
                    let newItem = Item()
                    
                    newItem.title = text
                    currentCategory.items.append(newItem)
                }
                }catch{
                    print(error)
                }
            }

           
            
           self.tableView.reloadData()
            print("success")
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    
    }
    func saveData(){
//        do{
//         try realm.write {
//            realm.add(item)
//        }
//        }catch{
//            print(error)
//        }
    }
    
    
    func loadItems ()
    {
        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@ " , selectedCategory!.name!)

        tableView.reloadData()
    }
    
  
    
}




extension ToDoListViewController : UISearchBarDelegate
{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       searchForText(searchBar: searchBar)
        
        print(searchBar.text!)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()

            }
        }
        else{
            searchForText(searchBar: searchBar)
        }
    }
    func searchForText(searchBar : UISearchBar){
     
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text! )

        todoItems = todoItems?.filter(predicate).sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
}

