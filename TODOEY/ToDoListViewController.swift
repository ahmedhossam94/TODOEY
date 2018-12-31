//
//  ViewController.swift
//  TODOEY
//
//  Created by ahmed on 12/31/18.
//  Copyright © 2018 ahmed. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    

 
    
    var itemsArray = ["hello","bye","goodbye"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemsArray[indexPath.row]
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if   tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
            
        else
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        

    }
    
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title:"Add Todoey New Item" , message: "", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Create New Item"
        }
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let text = alert.textFields![0].text!
            self.itemsArray.append(text)
           self.tableView.reloadData()
            print("success")
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    
    }
    
}

