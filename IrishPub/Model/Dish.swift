//
//  Dish.swift
//  IrishPub
//
//  Created by Алексей Сигай on 30/11/2018.
//  Copyright © 2018 Алексей Сигай. All rights reserved.
//

import Foundation

class Dish: Decodable {
    
    var name: String?
    var photo: String?
    var price: Double?
    var description: String?
}

struct ResponseMenu: Decodable {
    
    struct Response: Decodable {
        let items: [Dish]
    }
    let response: Response
}
