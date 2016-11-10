//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    var phrase : String!
    var phraseLength = 0
    var numAttempts = 0
    var currentPhrase = ""
    var phraseChars : [Character] = []
    var phraseCharSet : Set<Character> = []
    var gameOver = false
    var userWins = false
    var numGif = 1
    
    @IBOutlet weak var hangmanImage: UIImageView!
    @IBOutlet weak var attemptsLabel: UILabel!
    @IBOutlet weak var currentPhraseLabel: UILabel!
    @IBOutlet weak var guessTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        phrase = hangmanPhrases.getRandomPhrase()
        print(phrase)
        
        initializeGame()
    }
    
    @IBAction func startOverButton(_ sender: UIButton) {
        initializeGame()
    }
    @IBAction func guessButton(_ sender: UIButton) {
        if !gameOver && guessTextField.text != nil && guessTextField.text!.characters.count == 1 {
            let guess = Character(guessTextField.text!.lowercased())
            print(guess)
            guessTextField.text = nil
            if phraseCharSet.contains(guess) {
                var newPhrase = Array(currentPhraseLabel.text!.characters)
                
                for i in 0..<phraseLength {
                    if phraseChars[i] == guess {
                        newPhrase[i] = guess
                    }
                }
                currentPhraseLabel.text = String(newPhrase)
                phraseCharSet.remove(guess)
                print("Guessed \(guess) correctly!")
            }
            else {
                
                numAttempts += 1
                attemptsLabel.text = String(numAttempts)
                numGif += 1
                let newHangmanImage = "hangman" + String(numGif) + ".gif"
                hangmanImage.image = UIImage(named: newHangmanImage)
                print("Guessed \(guess) incorrectly!")
            }
 
        }
        checkGameState()
    }
   
    func checkGameState() {
        if phraseCharSet.isEmpty {
            print("You won!")
            gameOver = true
            userWins = true
        } else if numGif >= 7 {
            print("You lost :'(")
            gameOver = true
            userWins = false
        }
        if gameOver {
            var popup : String
            if userWins {
                popup = "You won!"
            } else {
                popup = "You lost :'("
            }
            let alertController = UIAlertController(title: "Game Over", message: popup, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        
        }
    }
    
    func initializeGame() {
        gameOver = false
        userWins = false
        numGif = 1
        currentPhrase = ""
        numAttempts = 0
        phraseLength = phrase.characters.count
        phraseChars = Array(phrase.lowercased().characters)
        phraseCharSet = Set(phrase.lowercased().characters)
        phraseCharSet.remove(" ")
        print(phraseCharSet)
    
        for i in 0..<phraseLength {
            if phraseChars[i] == " " {
                currentPhrase += " "
            } else {
                currentPhrase += "_"
            }
        }
        currentPhraseLabel.text = currentPhrase
        attemptsLabel.text = String(numAttempts)
        hangmanImage.image = UIImage(named: "hangman1.gif")
        
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
