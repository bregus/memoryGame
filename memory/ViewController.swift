//
//  ViewController.swift
//  memory
//
//  Created by Рома Сумороков on 29/03/2019.
//  Copyright © 2019 Рома Сумороков. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var memoryCards: [UIButton]!
    @IBOutlet weak var restartButton: UIButton!
    
    lazy var game = Memory(nubmerofPairsOfCards: memoryCards.count / 2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for btn in memoryCards {
            btn.layer.cornerRadius = 8.0
        }
        restartButton.layer.cornerRadius = 8.0
        restartButton.layer.position = CGPoint(x: view.center.x, y: -100)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func restartButtobPressed(_ sender: Any) {
        UIView.animate(withDuration: 0.8, animations: {
            self.restartButton.center = CGPoint(x: self.view.center.x, y: -100)
        })
        emoji = [Int : String]()
        emo = ["🦇", "🐺", "🐢", "🐙", "🦄", "🐦", "🦕", "🐳", "🦚", "🦉"]
        game.reset()
        for card in memoryCards {
            card.setTitle(nil, for: .normal)
            card.backgroundColor = nil
            card.setBackgroundImage(#imageLiteral(resourceName: "Card_back-Default.png"), for: .normal)
            UIView.animate(withDuration: 0.8, animations: {
                card.alpha = 1.0
            })
        }
    }
    
    @IBAction func cardButtonPressed(_ sender: UIButton) {
        if let cardIndex = memoryCards.firstIndex(of: sender) { //.index(Of: sender)
            game.chooseCard(at: cardIndex)

            updateButtons()
            
            if game.checkScore() {
                UIView.animate(withDuration: 2, delay: 1, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
                    self.restartButton.center = self.view.center
                })
            }
        } else {
            print("This button is not in button array")
        }
    }
    
    func updateButtons() {
        for btn in memoryCards.indices {
            let button = memoryCards[btn]
            let card = game.cards[btn]
            
                if card.isMatched {
                    UIView.animate(withDuration: 0.8, animations: {
                        button.alpha = 0.0
                    })
                }
                
                if card.isFaceUp {
                    if button.title(for: .normal) == nil {
                        button.setTitle(emoji(for: card), for: .normal)
                        button.backgroundColor = .white
                        button.setBackgroundImage(nil, for: .normal)
                        UIView.transition(with: button, duration: 0.5, options: .transitionFlipFromRight,animations: nil,  completion: nil)
                    }
                } else {
                    if button.title(for: .normal) != nil {
                        button.setTitle(nil, for: .normal)
                        button.backgroundColor = nil
                        button.setBackgroundImage(#imageLiteral(resourceName: "Card_back-Default.png"), for: .normal)
                        UIView.transition(with: button, duration: 0.4, options: .transitionFlipFromRight,animations: nil,  completion: nil)
                    }
                }
            
        }
    }
    
    var emo = ["🦇", "🐺", "🐢", "🐙", "🦄", "🐦", "🦕", "🐳", "🦚", "🦉"]
    var emoji = [Int : String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.id] == nil, emo.count > 0 {
            let randomIndex = Int.random(in: 0..<emo.count)
            emoji[card.id] = emo.remove(at: randomIndex)
        }
        return emoji[card.id] ?? "?"
    }
}

