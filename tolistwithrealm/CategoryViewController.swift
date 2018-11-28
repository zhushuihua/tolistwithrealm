//
//  ViewController.swift
//  tolistwithrealm
//
//  Created by Shuihua Zhu on 28/11/18.
//  Copyright © 2018 UMA Mental Arithmetic. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit
class CategoryViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var categories:Results<Category>!
    let realm = try! Realm()
    var selectedCategory:Category!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        tableView.reloadData()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        // Do any additional setup after loading the view, typically from a nib.
    }
    func loadCategories()
    {
        categories = realm.objects(Category.self)
    }
    func saveCategory(category:Category)
    {
        do
        {
                try realm.write {
                    realm.add(category)
            }
        }
        catch
        {
            print("save category error \(error)")
        }
    }
    @IBAction func addCategoryButtonPressed(_ sender: UIBarButtonItem) {
        var entry:UITextField!
        let alert = UIAlertController(title: "Add New Category", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            entry = textField
            entry.placeholder = "New Category"
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
            let category = Category()
            category.name = entry.text!
            self.saveCategory(category: category)
            self.tableView.reloadData()
        }
        alert.addAction(addAction)
        self.present(alert, animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToItems")
        {
            let d = segue.destination as! ItemsTableViewController
            d.selectedCategory = selectedCategory
        }
    }
}

extension CategoryViewController:UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else {return nil}
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { (action, indexPath) in
            let category = self.categories[indexPath.row]
            do{
                try self.realm.write {
                    self.realm.delete(category.items)
                    self.realm.delete(category)
                    //no need if there is a tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions
                   // self.tableView.reloadData()
                    
                }
            }
            catch{
                print("delete \(category) error \(error)")
            }
        }
        return [deleteAction]
        
    }
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCategory = categories[indexPath.row]
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
}
