//
//  LinkedNode.swift
//  AlgoQues
//
//  Created by Ong Wei Yap on 21/2/19.
//  Copyright © 2019 Ong Wei Yap. All rights reserved.
//

import Foundation

class LinkedNode<T> {
    var cache: T
    var previousNode: LinkedNode?
    var nextNode: LinkedNode?
    
    init(_ value: T) {
        self.cache = value
    }
}
