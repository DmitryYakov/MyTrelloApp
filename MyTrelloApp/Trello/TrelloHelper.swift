//
//  TrelloHelper.swift
//  MyTrelloApp
//
//  Created by YakovAlexey on 2/18/18.
//  Copyright © 2018 Alias. All rights reserved.
//

import Foundation

class TrelloHelper {
    static var apiKey = "e7a19325f58ab9581e05c0b762448a1c"
    static var authToken = "b933417d446ec4fb3000af3f286cba2f1b237ac97df0ebbf41c661e16f161558"
    
    static var boards : [Board]? = nil
    static var lists : [CardList]? = nil
    static var cards : [Card]? = nil
    
    static var trello: Trello? = nil
    
    static func initialize() {
        TrelloHelper.trello = Trello(apiKey:self.apiKey , authToken: self.authToken)
    }
    
    static func initialize(apiKey: String, authToken: String) {
        self.apiKey = apiKey
        self.authToken = authToken
        TrelloHelper.initialize()
    }

    static func getAllBoards(_ completion: @escaping (Result<[Board]>) -> Void) {
        TrelloHelper.trello?.getAllBoards({ (boards) in
            if boards.error == nil {
                TrelloHelper.boards = boards.value
            }
            completion(boards)
        })
    }
    
    static func geListsForBoards(_ id: String, filter: ListType = .Open, completion: @escaping (Result<[CardList]>) -> Void) {
        TrelloHelper.trello?.getListsForBoard(id, completion: { (cardlist) in
            if cardlist.error == nil {
                TrelloHelper.lists = cardlist.value
            }
            completion(cardlist)
        })
    }
    
    static func getCardsForList(_ id: String, withMembers: Bool = false, completion: @escaping (Result<[Card]>) -> Void) {
        TrelloHelper.trello?.getCardsForList(id, completion: { (cards) in
            if cards.error == nil {
                TrelloHelper.cards = cards.value
            }
            completion(cards)
        })
    }
    
    static public func addCardForList(_ id: String, name: String, completion: @escaping (Result<Card>) -> Void) {
        TrelloHelper.trello?.addCardForList(id, name: name, completion: { (card) in
            if card.error == nil {
                
            }
            completion(card)
        })
    }
    
    static public func addAttachmentForCard(_ id: String, name: String, mimeType: String, file: Data, completion: @escaping (Bool) -> Void) {
        TrelloHelper.trello?.addAttachmentForCard(id, name: name, mimeType: mimeType, file: file, completion: { (success) in
            completion(success)
        })
    }
}
