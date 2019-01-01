//
//  ViewController.swift
//  TODOEY
//
//  Created by ahmed on 12/31/18.
//  Copyright © 2018 ahmed. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
   
    var itemsArray = [Item]()
     let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
   // let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        print(dataFilePath)

      
loadItems()
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemsArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ?  .checkmark : .none
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

         itemsArray[indexPath.row].done = !itemsArray[indexPath.row].done
        saveData()
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
            
            let newItem = Item()
            newItem.title = text
            newItem.done = false
            self.itemsArray.append(newItem)
            
         self.saveData()
            
           self.tableView.reloadData()
            print("success")
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    
    }
    func saveData(){
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(self.itemsArray)
            try data.write(to: self.dataFilePath!)
        }catch{
            print("error encoding")
        }
    }
    func loadItems (){
        
            if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
                do{  itemsArray = try decoder.decode([Item].self, from: data)
       
                }
                catch{
            print("error decoding")
        }
    }
    }
    
}

