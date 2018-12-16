//
//  Reserve.swift
//  IrishPub
//
//  Created by Алексей Сигай on 11/12/2018.
//  Copyright © 2018 Алексей Сигай. All rights reserved.
//

import Foundation

struct Reserve: Codable {
    
    var name: String = ""
    var date: Date = Date()
    var time: Date = Date()
    var visitors: Int = 0
    var phone: Int = 0
    var comment: String?
}

struct RequestReserve: Codable {
    
    struct Request: Codable {
        let item: Reserve
    }
    let request: Request
}
