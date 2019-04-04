//
//  Card.swift
//  memory
//
//  Created by Рома Сумороков on 29/03/2019.
//  Copyright © 2019 Рома Сумороков. All rights reserved.
//

import Foundation

struct Card {
    var isMatched = false
    var isFaceUp = false
    var id: Int
    
    init() {
        self.id = Card.getUniqueIdentifier()
    }
    
    init(with id: Int) {
        self.id = id
    }

    static var lastIdentifier = -1
    
    static func getUniqueIdentifier() -> Int {
        self.lastIdentifier += 1
        return self.lastIdentifier
    }
    

}
