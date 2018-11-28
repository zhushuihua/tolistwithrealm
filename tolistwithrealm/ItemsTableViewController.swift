//
//  ItemsTableViewController.swift
//  tolistwithrealm
//
//  Created by Shuihua Zhu on 28/11/18.
//  Copyright © 2018 UMA Mental Arithmetic. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit
class ItemsTableViewController: UITableViewController {
    var selectedCategory:Category!
    var items:Results<Item>!
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SwipeTableViewCell
        cell.textLabel?.text = items[indexPath.row].title
        do{
            
        }
        // Configure the cell...

        return cell
    }

    @IBAction func addItemButtonPressed(_ sender: Any) {
        var entry:UITextField!
        let alert = UIAlertController(title: "Add New Category", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            entry = textField
            entry.placeholder = "New Item"
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
            let item = Item()
            item.title = entry.text!
            self.saveItem(item: item)
            self.tableView.reloadData()
        }
        alert.addAction(addAction)
        self.present(alert, animated: true, completion: nil)
    }
    func saveItem(item:Item)
    {
        do{
            try realm.write {
                selectedCategory.items.append(item)
                realm.add(item)
            }
        }
        catch{
            print("Save to realm error :\(error)")
        }
    }
    func loadItems()
    {
        items = selectedCategory.items.sorted(byKeyPath: "time", ascending: true)
        
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
