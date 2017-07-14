//
//  ItemViewController.swift
//  Homepwner
//
//  Created by byung-soo kwon on 2017. 7. 14..
//  Copyright © 2017년 BlackStoneTeam. All rights reserved.
//

import UIKit


class ItemViewController: UITableViewController{
 
    var itemStore: ItemStore!
    var newItem: [Int:[Item]] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 상태 바의 높이를 얻는다.
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
    
    // itemStore의 item 이 랜덤으로 변하기 때문에 셀 생성시에 만들어진 아이템을
    // 필터링해서 저장한다. 그리고 그 갯수만큼 섹션의 row 갯수를 설정한다.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let item = itemStore.allItems
        if section == 0 {
            newItem[section] = item.filter{ $0.valueInDollars < 50}
            guard let itemCount = newItem[section]?.count else {
                return 0
            }
            return itemCount
        }
        
        newItem[1] = item.filter{ $0.valueInDollars > 50}
        guard let itemCount = newItem[section]?.count else {
            return 0
        }
        return itemCount
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        if indexPath.section == 0 {
          
            let newItem = self.newItem[indexPath.section]![indexPath.row]
            if newItem.valueInDollars < 50 {
                cell.textLabel?.text = newItem.name
                cell.detailTextLabel?.text = "$\(newItem.valueInDollars)"
            }
            return cell
        }
        
        let newItem = self.newItem[indexPath.section]![indexPath.row]
        if newItem.valueInDollars > 50 {
            cell.textLabel?.text = newItem.name
            cell.detailTextLabel?.text = "$\(newItem.valueInDollars)"
        }
        return cell
    }
}
