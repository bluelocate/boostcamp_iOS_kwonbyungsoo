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
        
        switch section {
        case 0:
            newItem[section] = item.filter{ $0.valueInDollars < 50}
            guard let itemCount = newItem[section]?.count else {
                return 1
            }
            return itemCount
        case 1:
            newItem[section] = item.filter{ $0.valueInDollars >= 50}
            guard let itemCount = newItem[section]?.count else {
                return 1
            }
            return itemCount
        case 2:
            return 1
        default:
            return 1
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0,1:
            return "Section \(section)"
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 60
        case 1:
            return 60
        default:
            return 44
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "로도"))
        
        
        switch indexPath.section {
        case 0:
            
            guard let newItem = self.newItem[indexPath.section]?[indexPath.row] else {
                return cell
            }
            
            if newItem.valueInDollars < 50 {
                cell.textLabel?.text = newItem.name
                cell.textLabel?.font = UIFont.systemFont(ofSize: 20.0)
                cell.detailTextLabel?.text = "$\(newItem.valueInDollars)"
                cell.textLabel?.font = UIFont.systemFont(ofSize: 20.0)
                cell.backgroundColor = UIColor.clear
            }
            
            return cell
        case 1:
            guard let newItem = self.newItem[indexPath.section]?[indexPath.row] else {
                return cell
            }
            
            if newItem.valueInDollars >= 50 {
                cell.textLabel?.text = newItem.name
                cell.textLabel?.font = UIFont.systemFont(ofSize: 20.0)
                cell.detailTextLabel?.text = "$\(newItem.valueInDollars)"
                cell.textLabel?.font = UIFont.systemFont(ofSize: 20.0)
                cell.backgroundColor = UIColor.clear
            }
            
            return cell
        case 2:
            cell.textLabel?.text = "No more Items!"
            cell.detailTextLabel?.text = ""
            cell.backgroundColor = UIColor.clear
            return cell
        default:
            return cell
        }
    }
}
