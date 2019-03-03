//
//  ShoppingListItemCell.swift
//  Shopping List Realm
//
//  Created by Przemek on 2/23/19.
//  Copyright © 2019 Przemek. All rights reserved.
//

import UIKit
import ChameleonFramework

class ShoppingListItemCell: UITableViewCell {

    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var checkbox: UIImageView!
    @IBOutlet weak var cellView: UIView!
    
    var productString: String? {
        didSet {
            itemName.text = productString
        }
    }
    
    var isBought: Bool? {
        willSet {
            if isBought != newValue {
                if isBought == nil && newValue == true {
                    checkbox.alpha = CGFloat(1.0)
                    cellView.backgroundColor = FlatGreen()
                } else {
                    changeColorAndShowCheckbox(isBought: newValue)
                }
            }
        }
    }
    
    func changeColorAndShowCheckbox(isBought: Bool?) {
        if let bought = isBought {
            UIView.animate(withDuration: 0.2) {
                if (bought) {
                    self.checkbox.alpha = CGFloat(1.0)
                    self.cellView.backgroundColor = FlatGreen()
                } else {
                    self.checkbox.alpha = CGFloat(0.0)
                    self.cellView.backgroundColor = UIColor.white
                }
            }
        }
    }
    
    
}
