//
//  LRU.swift
//  AlgoQues
//
//  Created by Ong Wei Yap on 21/2/19.
//  Copyright © 2019 Ong Wei Yap. All rights reserved.
//

import Foundation

class LRU<Key: Hashable, Value> {
    
    private struct Cache {
        let key: Key
        let value: Value
    }
    
    private let list = LinkedList<Cache>()
    private var nodeDic = [Key: LinkedNode<Cache>]()
    private let capacity: Int
    
    init(capacity: Int) {
        self.capacity = max(0, capacity)
    }
    
    func add(withKey key: Key, _ value: Value) {
        let cache = Cache(key: key, value: value)
        
        if let node = nodeDic[key] {
            node.cache = cache
            list.moveNodeToHead(node)
            print("Moved to head: (Key) \(node.cache.key) (Value)\(node.cache.value),\n Head node: (Key)\(list.head?.cache.key) (Value) \(list.head?.cache.value),\n Head's nextNode node: (Key)\(list.head?.nextNode?.cache.key) (Value)\(list.head?.nextNode?.cache.value)")
        }
        else {
            let node = list.addNewNodeToHead(cache)
            nodeDic[key] = node
            print("new added: (Key) \(node.cache.key) (Value)\(node.cache.value),\n Head node: (Key)\(list.head?.cache.key) (Value) \(list.head?.cache.value),\n Head's previous node: (Key)\(list.head?.previousNode?.cache.key) (Value)\(list.head?.previousNode?.cache.value)")
        }
        
        if list.count > capacity {
            _ = list.removeLast()
        }
        
        print("Tail node: (Key) \(list.tail?.cache.key), (Value) \(list.tail?.cache.value), \n Tail next node: (Key) \(list.tail?.nextNode?.cache.key), (Value) \(list.tail?.nextNode?.cache.value)")
        
    }
    
    func get(withKey key: Key) {
        if let node = nodeDic[key] {
            list.moveNodeToHead(node)
            print("Get: (Key) \(node.cache.key) (Value)\(node.cache.value),\n Head node: (Key)\(list.head?.cache.key) (Value) \(list.head?.cache.value),\n Head's previous node: (Key)\(list.head?.previousNode?.cache.key) (Value)\(list.head?.previousNode?.cache.value)")
        }
        else {
            print("Could not get node with key")
        }
        print("Tail node: (Key) \(list.tail?.cache.key), (Value) \(list.tail?.cache.value), \n Tail next node: (Key) \(list.tail?.nextNode?.cache.key), (Value) \(list.tail?.nextNode?.cache.value)")
    }
    
    func remove(withKey key: Key) {
        if let node = nodeDic[key] {
            let node = list.removeNode(node)
            nodeDic[key] = nil
            print("Removed: (Key)\(node.cache.key), (Value)\(node.cache.value), \n Head node: (Key)\(list.head?.cache.key) (Value) \(list.head?.cache.value)")
        }
        else {
            print("Could not find node with the key")
        }
    }
    
    func evict() {
        if list.count > 0 {
            let node = list.removeLast()
            if let tempNode = node {
                nodeDic[tempNode.cache.key] = nil
            }
            print("Removed Last: (Key)\(node?.cache.key), (Value)\(node?.cache.value), \n Head node: (Key)\(list.head?.cache.key) (Value) \(list.head?.cache.value)")
        }
        else {
            print("empty list")
        }
    }
    
    func listCount() -> Int {
        return list.count
    }
    
    func getCapacity() -> Int {
        return self.capacity
    }
    
}
