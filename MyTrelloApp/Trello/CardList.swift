//
//  CardList.swift
//  Pods
//
//  Created by Joel Fischer on 4/8/16.
//
//

import Foundation

public struct CardList {
    public let id: String
    public let name: String
    public let boardId: String?
    public let pos: Float?
    public let subscribed: Bool?
    public let closed: Bool?
}

extension CardList: MyDecodable {
    public static func decode(_ json: Any) throws -> CardList {
        return try CardList(id: json => "id",
                            name: json => "name",
                            boardId: json =>? "idBoard",
                            pos: (json =>? "pos") as? Float,
                            subscribed: json =>? "subscribed",
                            closed: json =>? "closed")
    }
}

