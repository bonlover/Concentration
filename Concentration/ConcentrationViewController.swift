//
//  ConcentrationViewController.swift
//  Concentration
//
//  Created by Yungdrung Gyaltsen on 1/28/19.
//  Copyright © 2019 Yungdrung Gyaltsen. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController
{
    private lazy var game = Concentration(numberOfPaisOfCards : numberOfPairsOfCards)
    
    var numberOfPairsOfCards : Int {
        return (cardButtons.count + 1) / 2
    }
    
    private(set) var flipCount = 0 {
        didSet {
            updatedFlipCountLabel()
        }
    }
    
    private func updatedFlipCountLabel(){
        let attributes = [
            NSAttributedString.Key.strokeWidth : 5.0,
            NSAttributedString.Key.strokeColor : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ] as  [NSAttributedString.Key: Any]
        
        let attributedString = NSAttributedString(string: "Flips : \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updatedFlipCountLabel()
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        else{
            print("Chosen card was not in cardButtons")
        }
    }
    
    private func updateViewFromModel(){
        if cardButtons != nil {
            for index in cardButtons.indices{
                let button = cardButtons[index]
                let card = game.cards[index]
                if card.isFaceUp {
                    button.setTitle(emoji(for : card), for: .normal)
                    button.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
                }else{
                    button.setTitle("", for: .normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0, green: 0.6010109639, blue: 0.9745291096, alpha: 0.8673212757)
                }
            }
        }
    }
    var theme : String? {
        didSet {
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
    
//    private var emojiChoices : Array<String> = ["👹","👻","🤡","🎃","👺","😈","👽","🤖","🐍","🦅","🐷","🌖"]
    
    private var emojiChoices = "👹👻🤡🎃👺👽🤖🐍🦅🐷🌖"

    private var emoji = [Card:String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0
        {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at:randomStringIndex))
        }
//        if emoji[card.identifier] != nil{
//            return emoji[card.identifier]!
//        }else{
//          return "?"
//        }
        return emoji[card] ?? "?"
    }
}

extension Int {
    var arc4random : Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        }
        else if self < 0{
            return -Int(arc4random_uniform(UInt32(self)))
        }
        else{
            return 0
        }
    }
}
