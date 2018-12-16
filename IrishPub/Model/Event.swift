//
//  Event.swift
//  IrishPub
//
//  Created by Алексей Сигай on 08/12/2018.
//  Copyright © 2018 Алексей Сигай. All rights reserved.
//

import Foundation

class Event: Decodable {
    
    var event_id: Int?
    var headline: String?
    var photo: String?
    var description: String?
    var date: Date?
}

struct ResponseEvents: Decodable {
    
    struct Response: Decodable {
        let items: [Event]
    }
    let response: Response
}
