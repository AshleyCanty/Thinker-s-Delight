//
//  GameSessionTableViewDataSource.swift
//  ThinkersDelight
//
//  Created by ashley canty on 5/22/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit

// MARK: UITableViewDataSource

extension GameSessionVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let list = triviaList {
            
            if list.count > 0 {
                let incorrectAnswers = list[currentTriviaIndex].incorrect_answers
                let correctAnswer = list[currentTriviaIndex].correct_answer
                
                if currentAnswers.count == 0 {
                    setupQuestion()
                    incorrectAnswers?.forEach({ (ans) in
                        currentAnswers.append(ans)
                    })
                    
                    currentAnswers.append(correctAnswer ?? "")
                    currentAnswers.shuffle()

                    self.startTimer()
                }
            }
        }
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "answerCell", for: indexPath) as! AnswerCell
            cell.placeNumberLabel.text = "1)"
            if (currentAnswers.count > 1) {
                currentAnswers[0].replaceCharacters()
                cell.answerLabel.text = currentAnswers[0]
            } else {
                cell.answerLabel.text = ""
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "answerCell", for: indexPath) as! AnswerCell
            cell.placeNumberLabel.text = "2)"
            if (currentAnswers.count > 1) {
                currentAnswers[1].replaceCharacters()
                cell.answerLabel.text = currentAnswers[1]
            } else {
                cell.answerLabel.text = ""
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "answerCell", for: indexPath) as! AnswerCell
            cell.placeNumberLabel.text = "3)"
            if (currentAnswers.count > 1) {
                currentAnswers[2].replaceCharacters()
                cell.answerLabel.text = currentAnswers[2]
            } else {
                cell.answerLabel.text = ""
            }
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "answerCell", for: indexPath) as! AnswerCell
            cell.placeNumberLabel.text = "4)"
            if (currentAnswers.count > 1) {
                currentAnswers[3].replaceCharacters()
                cell.answerLabel.text = currentAnswers[3]
            } else {
                cell.answerLabel.text = ""
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "answerCell", for: indexPath)
            cell.selectionStyle = .gray
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as? AnswerCell {
            cell.backgroundColor = Colors.yellow
            cell.answerLabel.textColor = Colors.darkBlue
            cell.placeNumberLabel.textColor = Colors.darkBlue
            selectedAnswer = cell.answerLabel.text ?? ""
        }
        resetUnselectedRowColors(indexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.alpha = 0
        
        UIView.animate(
            withDuration: 0.3,
            delay: 0.03 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
        })
    }
}
