//
//  SideMenuVC.swift
//  ThinkersDelight
//
//  Created by ashley canty on 5/20/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit

class SideMenuVC: UITableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        NotificationCenter.default.post(name: Notification.Name("ToggleSideMenu"), object: nil)
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 {
            let row = indexPath.row
            if row == 0 {
                NotificationCenter.default.post(name: Notification.Name("showMainMenu"), object: nil)
            }
            if row == 1 {
                NotificationCenter.default.post(name: Notification.Name("Logout"), object: nil)
            }
        }
    }
}
