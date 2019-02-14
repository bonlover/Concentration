//
//  Concentration.swift
//  Concentration
//
//  Created by Yungdrung Gyaltsen on 1/31/19.
//  Copyright © 2019 Yungdrung Gyaltsen. All rights reserved.
//

import Foundation
struct Concentration
{
    private(set) var cards = [Card]()
    private var indexOfOneAndOnlyFaceUpCard : Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
            
//            var foundIndex : Int?
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    if foundIndex == nil {
//                        foundIndex = index
//                    }else{
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)) :chosen index not in the cards")
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index]{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            }
            else{
                //either no cards or 2 cards are face up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPaisOfCards: Int) {
        assert(numberOfPaisOfCards > 0, "Concentration.init(\(numberOfPaisOfCards)) : you must have at least one of cards")
        for _ in 1...numberOfPaisOfCards
        {
            let card = Card()
            cards += [card,card]
        }
        
        //TODO : Shuffle the cards
        cards.shuffle()
    }
}

extension Collection {
    var oneAndOnly : Element? {
        return count == 1 ? first : nil
    }
}
