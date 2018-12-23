//
//  Item.swift
//  ToDoList
//
//  Created by Chen Wang on 11/14/18.
//  Copyright © 2018 Chen Wang. All rights reserved.
//

import Foundation

class Item : Encodable, Decodable{
    var title: String = ""
    var done: Bool = false
}
