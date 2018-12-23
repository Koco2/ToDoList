//
//  ViewController.swift
//  ToDoList
//
//  Created by Chen Wang on 11/13/18.
//  Copyright © 2018 Chen Wang. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    
    var itemArray = [Item]()
    var dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        dataFilePath?.appendPathComponent("items.plist")
        loadItem()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        if itemArray[indexPath.row].done == true{
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        
        
        return cell;
    }

    
    //MARK: tableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        if itemArray[indexPath.row].done == false{
            itemArray[indexPath.row].done = true
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }else{
            itemArray[indexPath.row].done = false
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        
        saveItem()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: Add New Items Section
    
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        saveItem()
        
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add New Item", style: .default) { (action) in
            //what happen once the alert is clicked
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)

            self.saveItem()
            self.tableView.reloadData()
            print("success")
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func saveItem(){
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(self.itemArray)
            try data.write(to: self.dataFilePath!)
        }catch{
            print("error in encodding, \(error)")
        }
    }
    
    private func loadItem(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([Item].self, from: data)
            }catch{
                print("error in decode, \(error)")
            }
        }
    }
    
}

