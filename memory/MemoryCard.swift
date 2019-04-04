//
//  MemoryCard.swift
//  memory
//
//  Created by Рома Сумороков on 29/03/2019.
//  Copyright © 2019 Рома Сумороков. All rights reserved.
//

import Foundation

class Memory {
    var cards = [Card]()
    var indexOfFaceUpCard: Int?
    var score = 0
    
    func chooseCard(at index: Int)  {
        if cards[index].isMatched {
            return
        }
        if let matchIndex = indexOfFaceUpCard, matchIndex != index {
            if cards[matchIndex].id == cards[index].id {
                cards[matchIndex].isMatched = true
                cards[index].isMatched = true
                score += 2
            }
            cards[index].isFaceUp = true
            indexOfFaceUpCard = nil
        } else {
            for cardIndex in cards.indices {
                cards[cardIndex].isFaceUp = false
            }
            cards[index].isFaceUp = true
            indexOfFaceUpCard = index
        }
    }
    
    func reset() {
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
        score = 0
    }
    
    func checkScore() -> Bool {
        if score == cards.count {
           return true
        }
        return false
    }
    
    init(nubmerofPairsOfCards: Int) {
        for _ in 1...nubmerofPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
}
