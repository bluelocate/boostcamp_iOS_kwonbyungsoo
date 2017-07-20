//
//  ItemStore.swift
//  Homepwner
//
//  Created by byung-soo kwon on 2017. 7. 14..
//  Copyright © 2017년 BlackStoneTeam. All rights reserved.
//

import UIKit

class ItemStore{
    
    var allItems: [Item] = []
    
    func createItem() -> Item {
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
    }
    
    init() {
        for _ in 0..<5{
            createItem()
        }
    }
}
