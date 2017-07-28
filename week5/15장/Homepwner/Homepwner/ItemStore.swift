//
//  Copyright © 2015 Big Nerd Ranch
//

import Foundation

class ItemStore {
    
    var allItems: [Item] = []
    let itemArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        guard let documentDirectory = documentsDirectories.first else {
            fatalError("wrong Path!")
        }
        return documentDirectory.appendingPathComponent("item.archive")
        
    }()
    
    init() {
        if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: itemArchiveURL.path) as? [Item] {
            allItems += archivedItems
        }
    }
    
    func moveItemAtIndex(_ fromIndex: Int, toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        // Get reference to object being moved so you can re-insert it
        let movedItem = allItems[fromIndex]
        
        // Remove item from array
        allItems.remove(at: fromIndex)
        
        // Insert item in array at new location
        allItems.insert(movedItem, at: toIndex)
    }
    
    func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        
        return newItem
    }
    
    func removeItem(_ item: Item) {
        if let index = allItems.index(of: item) {
            allItems.remove(at: index)
        }
    }
    
    func saveChanged() -> Bool {
        
        print("Saving items to: \(itemArchiveURL.path)")
        
        return NSKeyedArchiver.archiveRootObject(allItems, toFile: itemArchiveURL.path)
    }
    
}
