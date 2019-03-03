//
//  ShoppingListCellCollectionViewCell.swift
//  Shopping List Realm
//
//  Created by Przemek on 2/24/19.
//  Copyright © 2019 Przemek. All rights reserved.
//

import UIKit


class ShoppingListCellCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var listName: UILabel!
    @IBOutlet weak var listCreationDate: UILabel!
    
    var name: String? {
        didSet {
            listName.text = name
        }
    }
    
    var date: Date?
}
