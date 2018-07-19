//
//  CategoryViewController.swift
//  Todoey
//
//  Created by 刘祥 on 7/18/18.
//  Copyright © 2018 Orange Arrow. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        
        let category = categoryArray[indexPath.row]
        cell.textLabel?.text = category.name

        return cell
        
    }
    
    
    // MARK - FUNC FOR TABLEVIEW DELEGATE
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! Todoey
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }


    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add a category for your list", message: "", preferredStyle: .alert)
        var textField = UITextField()
        let action = UIAlertAction(title: "ADD", style: .default) { (action) in
            let newCategory = Category(context:self.context)
            newCategory.name = textField.text!
            self.categoryArray.append(newCategory)
            
            self.saveCategory()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "please type your categories"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
        
    func saveCategory(){
        do{
            try context.save()
                
        }catch{
            print("Error is \(error)")
        }
            
        self.tableView.reloadData()
    }
        
        
        func loadCategories(with request:NSFetchRequest<Category> = Category.fetchRequest()){
            
            do{
                categoryArray = try context.fetch(request)
            }catch{
                print("error is \(error)")
            }
            tableView.reloadData()
        }
    

}
