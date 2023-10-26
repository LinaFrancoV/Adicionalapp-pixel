//
//  ViewController.swift
//  prueba correcion
//
//  Created by Lina Franco Vega on 26/10/23.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    let wordsForTheGame: [String] = ["algorithm", "language", "compiler", "variable", "function", "loop", "class", "object", "inheritance", "polymorphism", "encapsulation", "modularity", "debugging", "integration", "development", "frontend", "backend", "database", "API", "framework", "library", "programmer", "syntax", "compilation", "interpretation", "link", "optimization", "repository", "constant"]
    var numberOfAttempts: Int = 8
    var arrayToGuessResult: [Character] = []
    
    
    
    //@IBOutlet weak var letterButtons: UIButton!
    @IBOutlet weak var startWordSecretNew: UIButton!
    @IBOutlet var labelSecretWordView: UILabel!
    @IBOutlet weak var labelNumberOfAttemptsAvailable: UILabel!
    //@IBOutlet weak var commentsView: UILabel!
    //@IBOutlet var infoGame: UILabel!
    //@IBOutlet weak var imageLogo: UIImageView!
    
    @IBAction func startNewWord(_ sender: UIButton) {
    generateRandomWord(wordsForTheGame)
    }
    
    var letterEnteredByUser: Character?
    
    @IBAction func letterEnteredUser(_ sender: UIButton) {
        if let buttonText = sender.titleLabel?.text, buttonText.count == 1 {
            let letterEntered = buttonText.lowercased()
            print(letterEntered)
        } else {
            print("No hay letra")
        }
    }
    
    
//    func configureButtons() {
//        letterButtons.titleLabel?.font = UIFont.systemFont
//        let selectedColorImage = UIImage(color: UIColor.red)
//        button.setBackgroundImage(selectedColorImage, for: .selected)
//    }
    
    // Generate a random word from wordsForTheGame
    func generateRandomWord(_ wordsForTheGame: [String]) -> String {
        return wordsForTheGame.randomElement() ?? ""
    }
    
    // Identify letters in a word
    func letterIdentifier(_ randomWord: String, _ characterArray: [Character]) {
        for letterEnteredByUser in randomWord {
            var secretWord = ""
            if characterArray.contains(letterEnteredByUser) {
                secretWord.append(letterEnteredByUser)
            } else {
                secretWord.append(" _ ")
            }
            labelSecretWordView.text = secretWord
        }
        
        print()
    }
    
    // Guess a letter
    func guessTheLetter() -> Character {
        
        print("Enter a letter: ", terminator: "")
        
        while letterEnteredByUser?.isLetter == false || letterEnteredByUser?.description.count != 1 {
            print("Please enter only one letter: ", terminator: "")
        }
        let letter = letterEnteredByUser!
        
        if arrayToGuessResult.contains(letter) {
            print("You already guessed that letter, try another one: ", terminator: "")
        }
        
        return letter
    }
    
    // Initialize the Danger Words game
    func initDangerWords() {
        let secretWord = generateRandomWord(wordsForTheGame)
        while true {
            letterIdentifier(secretWord, arrayToGuessResult)
            let guessResult = guessTheLetter()
            
            labelNumberOfAttemptsAvailable.text = String(numberOfAttempts)
            if secretWord.contains(guessResult) {
                arrayToGuessResult.append(guessResult)
                print("Well done! You guessed a letter.")
            } else {
                numberOfAttempts -= 1
                
                if numberOfAttempts == 0 {
                    print("Game Over! The word was: \(secretWord)")
                    break
                } else if Set(secretWord).isSubset(of: Set(arrayToGuessResult)) {
                    print("Congratulations! You guessed the word: \(secretWord)")
                    break
                }
            }
        }
    }
}

//let game = PlayDangerWords()
//    game;.initDangerWords()
