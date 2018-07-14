//
//  ViewController.swift
//  Todoey
//
//  Created by 刘祥 on 7/11/18.
//  Copyright © 2018 Orange Arrow. All rights reserved.
//

import UIKit

class Todoey: UITableViewController {
    
    var itemArray = [Item]()
    
//    let defaults = UserDefaults.standard
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let item1 = Item()
//        item1.title = "Listings"
//        itemArray.append(item1)
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items
//        }
        loadItems()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoeyCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        }else{
//            cell.accessoryType = .none
//        }
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItem()

//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }else{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    //MARK - ADD BAR BUTTON PRESSED FUNC
    @IBAction func barBtnPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add a event to do", message: "", preferredStyle: .alert)
        var textField = UITextField()
        let action = UIAlertAction(title: "ADD", style: .default) { (action) in
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)

//            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.saveItem()


        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "please type your events"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK - func for save data using encoder
    func saveItem(){
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to : dataFilePath!)
        }catch{
            print("Error is \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    //MARK - func for retrive data back using decoder
    func loadItems(){
        
        if let data = try?Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([Item].self, from: data)
            }catch{
                print("Error is \(error)")
            }
        }
    }
    

}

