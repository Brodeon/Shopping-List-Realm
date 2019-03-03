//
//  ItemsViewController.swift
//  Shopping List Realm
//
//  Created by Przemek on 2/23/19.
//  Copyright © 2019 Przemek. All rights reserved.
//

import UIKit
import RealmSwift

class ItemsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var items: Results<ShoppingListItem>?
    var realm = try! Realm()
    
    @IBOutlet weak var itemsTV: UITableView!
    
    var selectedList: ShoppingList?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemsTV.delegate = self
        itemsTV.dataSource = self
        itemsTV.separatorStyle = .none
        
        loadItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.title = selectedList?.listName
    }
    
    func loadItems() {
        items = selectedList?.shoppingListItems.sorted(byKeyPath: "itemCreationDate")
        itemsTV.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ShoppingListItemCell
        cell.isBought = item?.isBought
        cell.productString = item?.productString
        return cell
    }
    
    @IBAction func addListItem(_ sender: UIBarButtonItem) {
        var textView: UITextField?
        let alert = UIAlertController(title: "Add a new product", message: "", preferredStyle: .alert)
        
        alert.addTextField { (UITextView) in
            UITextView.placeholder = "name of the new product"
            textView = UITextView
        }
        
        let action = UIAlertAction(title: "Add", style: .default) { (UIAlertAction) in
            do {
                if let list = self.selectedList {
                    try self.realm.write {
                        let item = ShoppingListItem()
                        item.productString = textView!.text!
                        item.isBought = false
                        item.itemCreationDate = Date()
                        list.shoppingListItems.append(item)
                    }
                }
            } catch {
                print("Realm save item error \(error)")
            }
            
            self.itemsTV.reloadData()
        }
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = items?[indexPath.row]
        if let item = selectedItem {
            do {
                try realm.write {
                    item.isBought = !item.isBought
                }
                tableView.deselectRow(at: indexPath, animated: true)
                itemsTV.reloadData()
            } catch {
                print("updating value error \(error)")
            }
        }
    }
    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//
//    }
    
}
