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
    var isFirst = true
    @IBAction func addNewItem(_ sender: AnyObject){
        
        // 새 물품을 만들고 그것을 저장소에 추가한다.
        let newItem = itemStore.createItem()
        // 배열 안에서 이 항목의 위치를 계산한다.
        if let index = itemStore.allItems.index(of: newItem){
            let indexPath = IndexPath(row: index - 1, section: 0)
            
            // 테이블에 새로운 행을 삽입한다
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    @IBAction func toggleEditingMode(_ sender: AnyObject){
        
        // 현재 편집 모드이면
        if isEditing{
            //사용자에게 상태를 알리기 위해 버튼의 텍스트를 변경한다.
            sender.setTitle("Edit", for: .normal)
            // 편집 모드를 끈다
            setEditing(false, animated: true)
        } else {
            sender.setTitle("Done", for: .normal)
            // 편집 모드로 돌아간다.
            setEditing(true, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemStore.createItem()
        // 상태 바의 높이를 얻는다.
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle{
        if indexPath.row == (tableView.numberOfRows(inSection: 0) - 1){
            return .none
        }
        return .delete
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let item = itemStore.allItems[indexPath.row]
        // 재사용 셀이나 새로운 셀을 얻는다.
        // 물품 배열의 n번째에 있는 항목의 설명을 n과 row와 일치하는 셀의 텍스트로 설정한다.
        // 이 셀은 테이블 뷰의 n번째 행에 나타난다.
        if indexPath.row == (tableView.numberOfRows(inSection: 0) - 1){
            cell.textLabel?.text = "No more Items!"
            cell.detailTextLabel?.text = ""
            cell.isUserInteractionEnabled = false
            return cell
        }
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Remove"
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        
        let item = itemStore.allItems[indexPath.row]
        let title = "Delete \(item.name)?"
        let message = "Are you sure you want to delete this item?"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        //테이블 뷰가 삭제 명령의 적용을 요청하면
        if editingStyle == .delete {
            let deleteAction = UIAlertAction(title: "Remove", style: .destructive, handler: { (action) -> Void in
                self.itemStore.removeItem(item: item)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            alertController.addAction(deleteAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            moveRowAt sourceIndexPath: IndexPath,
                            to destinationIndexPath: IndexPath) {
        //모델을 업데이트한다
        if destinationIndexPath.row == (tableView.numberOfRows(inSection: 0) - 1) {
            print("여기는 마지막행")
            tableView.reloadData()
        } else {
            print("이동했다! \(sourceIndexPath.row) 에서 \(destinationIndexPath.row)")
            itemStore.moveItemAtIndex(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == (tableView.numberOfRows(inSection: 0) - 1){
            return false
        }
        return true
    }
}
