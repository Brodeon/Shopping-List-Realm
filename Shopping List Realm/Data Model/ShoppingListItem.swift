//
//  ShoppingListItem.swift
//  Shopping List Realm
//
//  Created by Przemek on 2/23/19.
//  Copyright © 2019 Przemek. All rights reserved.
//

import Foundation
import RealmSwift

class ShoppingListItem: Object {
    
    @objc dynamic var productString: String = ""
    @objc dynamic var isBought: Bool = false
    @objc dynamic var itemCreationDate: Date?
    
    var parentShoppingList = LinkingObjects(fromType: ShoppingList.self, property: "shoppingListItems")
}
