//
//  foodElem.swift
//  ExamApp
//
//  Created by OparinOleg on 02.06.2020.
//  Copyright © 2020 OparinOleg. All rights reserved.
//

import Foundation

class foodElem{
    
    let cost: String
    let name: String
    let description: String
    
    init(name: String, cost: String, description: String) {
        self.cost = cost
        self.name = name
        self.description = description
    }
}
