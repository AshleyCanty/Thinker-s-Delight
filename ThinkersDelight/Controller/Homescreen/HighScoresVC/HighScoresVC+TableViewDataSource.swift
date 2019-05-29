//
//  HighScoreVC+TableViewDataSource.swift
//  ThinkersDelight
//
//  Created by ashley canty on 5/27/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit

extension HighScoresViewControlller: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        var currentScores: [Result] = []
        
        if currentScorelevel == 0 {
            currentScores = easyScores
        } else if currentScorelevel == 1 {
            currentScores = mediumScores
        } else {
            currentScores = hardScores
        }

        if row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath) as! ScoreTableCell
            cell.placeNumberLabel.text = "1"

            if currentScores.count > 0 && indexPath.row <= currentScores.count-1{
                cell.scoreObject = currentScores[indexPath.row]
            } else {
                cell.scoreObject = nil
            }
            return cell
        } else if row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath) as! ScoreTableCell
            cell.placeNumberLabel.text = "2"

            if currentScores.count > 0 && indexPath.row <= currentScores.count-1{
                cell.scoreObject = currentScores[indexPath.row]
            } else {
                cell.scoreObject = nil
            }
            return cell
        } else if row  == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath) as! ScoreTableCell
            cell.placeNumberLabel.text = "3"
            
            if currentScores.count > 0 && indexPath.row <= currentScores.count-1{
                cell.scoreObject = currentScores[indexPath.row]
            } else {
                cell.scoreObject = nil
            }
            return cell
        } else if row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath) as! ScoreTableCell
            cell.placeNumberLabel.text = "4"
            if currentScores.count > 0 && indexPath.row <= currentScores.count-1{
                cell.scoreObject = currentScores[indexPath.row]
            } else {
                cell.scoreObject = nil
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath) as! ScoreTableCell
            cell.placeNumberLabel.text = "5"
            if currentScores.count > 0 && indexPath.row <= currentScores.count-1{
                cell.scoreObject = currentScores[indexPath.row]
            } else {
                cell.scoreObject = nil
            }
            return cell
        }
    }
}
