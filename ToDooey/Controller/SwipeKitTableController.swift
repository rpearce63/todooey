//
//  SwipeKitTableCell.swift
//  ToDooey
//
//  Created by Rick Pearce on 4/25/18.
//  Copyright © 2018 Pearce. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeKitTableController: UITableViewController,  SwipeTableViewCellDelegate {
    
    override func viewDidLoad() {
        self.tableView.rowHeight = 65
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SwipeTableViewCell
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.deleteItem(indexPath: indexPath)
        }
        deleteAction.image = UIImage(named: "delete")
        
        return [deleteAction]
    }
    
    public func deleteItem(indexPath: IndexPath) {
        
    }

    

}
