//
//  ShoppingList.swift
//  Shopping List Realm
//
//  Created by Przemek on 2/23/19.
//  Copyright © 2019 Przemek. All rights reserved.
//

import Foundation
import RealmSwift

class ShoppingList: Object  {
    
    @objc dynamic var listName: String = ""
    @objc dynamic var listCreationDate: Date?
    
    let shoppingListItems = List<ShoppingListItem>()
}
