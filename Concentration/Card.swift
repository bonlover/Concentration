//
//  Card.swift
//  Concentration
//
//  Created by Yungdrung Gyaltsen on 1/31/19.
//  Copyright © 2019 Yungdrung Gyaltsen. All rights reserved.
//

import Foundation

struct Card : Hashable
{
    var hashValue : Int { return identifier}
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    var isFaceUp = false
    var isMatched = false
    private var identifier : Int
    
    private static var identifierFactory = 0
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init()
    {
        self.identifier = Card.getUniqueIdentifier()
    }
}
