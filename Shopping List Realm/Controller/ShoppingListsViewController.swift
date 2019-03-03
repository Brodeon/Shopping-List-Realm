//
//  ViewController.swift
//  Shopping List Realm
//
//  Created by Przemek on 2/23/19.
//  Copyright © 2019 Przemek. All rights reserved.
//

import UIKit
import RealmSwift

class ShoppingListsViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var realm = try! Realm()
    var lists: Results<ShoppingList>?
    var selectedList: ShoppingList?
    
    @IBOutlet weak var listsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listsCollectionView.delegate = self
        listsCollectionView.dataSource = self
        
        loadLists()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lists?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let list = lists?[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listCell", for: indexPath) as! ShoppingListCellCollectionViewCell
        cell.name = list?.listName
        
        cell.layer.borderWidth = CGFloat(2.0)
        cell.layer.borderColor = UIColor(hexString: "FF5733")?.cgColor
        cell.layer.cornerRadius = CGFloat(5.0)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedList = lists?[indexPath.row]
        
        if let list = selectedList {
            performSegue(withIdentifier: "toItems", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toItems" {
            let destinationVc = segue.destination as! ItemsViewController
            destinationVc.selectedList = self.selectedList
        }
    }
    
    func loadLists() {
        lists = realm.objects(ShoppingList.self).sorted(byKeyPath: "listCreationDate")
        listsCollectionView.reloadData()
    }

    @IBAction func addList(_ sender: UIBarButtonItem) {
        var textView: UITextField?
        let alert = UIAlertController(title: "Create a new shopping list", message: "", preferredStyle: .alert)
        
        alert.addTextField { (UITextView) in
            UITextView.placeholder = "name of a new shopping list"
            textView = UITextView
        }
        
        let action = UIAlertAction(title: "Add", style: .default) { (UIAlertAction) in
            do {
                try self.realm.write {
                    let list = ShoppingList()
                    list.listName = textView!.text!
                    list.listCreationDate = Date()
                    self.realm.add(list)
                }
            } catch {
                print("Realm save item error \(error)")
            }
            
            self.listsCollectionView.reloadData()
        }
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

