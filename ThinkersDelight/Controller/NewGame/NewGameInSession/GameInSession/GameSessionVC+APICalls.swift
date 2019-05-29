//
//  GameSession+APICalls.swift
//  ThinkersDelight
//
//  Created by ashley canty on 5/22/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit

// MARK: - API Call for Data

extension GameSessionVC {
    func reloadTable(){
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func fetchQuestionAndAnswers() {
        setupSpinner()
        let category = userDefaults.string(forKey: UserDefaultKeys.Category.rawValue)
        let level = userDefaults.string(forKey: UserDefaultKeys.Difficulty.rawValue)
        let amount = userDefaults.string(forKey: UserDefaultKeys.Count.rawValue)
        guard let url = URL(string: "http://opentdb.com/api.php?amount=\(amount ?? "10")&category=\(category ?? "1")&difficulty=\(level ?? "easy")&type=multiple") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, res, err) in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(TriviaResponse.self, from: data)
                    if let list = result.results as? [Trivia] {
                        self.triviaList = list
                        self.triviaList?.shuffle()
                        self.removeSpinner()
                        self.reloadTable()
                    }
                    
                } catch {
                    print(error)
                }
            }
            }.resume()
    }
    
    func printUserDefualts() {
        for (key, value) in userDefaults.dictionaryRepresentation() {
            //            print("\(key): \(value)")
        }
    }
    
    
    // MARK: - Game State Functions
    
    func checkForCompletionOfQuiz() {
        var currentIndex = currentTriviaIndex
        currentIndex += 1
        if let list = self.triviaList {
            if currentIndex == list.count {
                self.presentQuizCompletedAlert()
            } else {
                self.loadNextQuestion()
            }
        }
    }
    
    func loadNextQuestion() {
        if triviaList != nil {
            currentTriviaIndex += 1
            setupQuestion()
            resetMarkerImages()
            state.resetForNewQuestion()
            resetUnselectedRowColors(indexPath: IndexPath(row: 5, section: 0))
            resetTimeLabel()
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func setupQuestion() {
        guard let list = triviaList else { return }
        let count = list.count
        
        if count != 0 {
            if let triviaList = triviaList {
                let counter = String(currentTriviaIndex+1)
                let trivia = triviaList[currentTriviaIndex]
                
                var parsedQuestion = trivia.question!
                parsedQuestion.replaceCharacters()
                
                currentAnswers = []
                questionLabel.text = parsedQuestion
                counterLabel.text = "Question \(counter)/\(triviaList.count)"
                
                questionLabel.alpha = 0
                counterLabel.alpha = 0
                
                UIView.animate(
                    withDuration: 0.3,
                    delay: 0.03,
                    animations: {
                        self.questionLabel.alpha = 1
                        self.counterLabel.alpha = 1
                })
            }
        }
    }
    
    func updateGameState() {
        if let trivia = triviaList?[currentTriviaIndex] {
            let correctAnswer = trivia.correct_answer
            
            if correctAnswer == selectedAnswer {                state.calculateAllPointsForCurrentQuestion()
                totalScoreLabel.text = String(state.totalPoints)
                countdownTimer.invalidate()
                presentCorrectAnswerAlert()
                return
            }
            state.subtractRemainingAttempts()
            updateMarkerImages()
            if state.checkRemainingAttempts() == false {
                endTimer()
                presentRemainingAttemptsAlert()
            }
        }
    }
    
}
