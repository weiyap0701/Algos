//
//  LinkedList.swift
//  AlgoQues
//
//  Created by Ong Wei Yap on 21/2/19.
//  Copyright © 2019 Ong Wei Yap. All rights reserved.
//

import Foundation

class LinkedList<T> {
    
    typealias Node = LinkedNode<T>
    
    var count: Int = 0
    var head: Node?
    var tail: Node?
    
    func addNewNodeToHead(_ value: T) -> Node {
        let newNode = Node(value)
        
        guard let tempHead = head else {
            head = newNode
            tail = newNode
            count += 1
            return newNode
        }
        
        tempHead.nextNode = newNode
        newNode.previousNode = tempHead
        head = newNode
        
        count += 1
        return newNode
    }
    
    func moveNodeToHead(_ node: Node) {
        let previousNode = node.previousNode
        let nextNode = node.nextNode
        
        previousNode?.nextNode = nextNode
        nextNode?.previousNode = previousNode
        
        if node === head {
            return
        }
        
        node.previousNode = head
        head?.nextNode = node
        
        head = node
        
        if previousNode == nil { //tail
            tail = nextNode
        }
    }
    
    func removeNode(_ node: Node) -> Node {
        let previousNode = node.previousNode
        let nextNode = node.nextNode
        
        previousNode?.nextNode = nextNode
        nextNode?.previousNode = previousNode
        
        if previousNode == nil { //tail
            tail = nextNode
        }
        
        if node === head {
            head = previousNode
            head?.nextNode = nextNode
        }
        
        count -= 1
        return node
    }
    
    func removeLast() -> Node? {
        if tail != nil {
            return removeNode(tail!)
        }
        return nil
    }
    
}
