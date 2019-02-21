//
//  LRUCollectionController+CollectionView.swift
//  AlgoQues
//
//  Created by Ong Wei Yap on 21/2/19.
//  Copyright © 2019 Ong Wei Yap. All rights reserved.
//

import UIKit

extension LRUCollectionController: UICollectionViewDelegateFlowLayout {
    
    func collectionAdd(key: Int) {
        if let _ = keyForCell[key] {
            for item in 0..<count - 1{
                let indexPath = IndexPath(item: item, section: 0)
                let cell = collectionView.cellForItem(at: indexPath) as! LRUInfoCell
                if let cellKey = cell.key {
                    if cellKey == key {
                        let headIndexPath = IndexPath(item: count - 1, section: 0)
                        cell.setInfoText(key: key, text: textView.text)
                        collectionView.moveItem(at: indexPath, to: headIndexPath)
                        break
                    }
                }
            }
        }
        else {
            count += 1

            let headIndexPathItem = count - 1
            let headIndexPath = IndexPath(item: headIndexPathItem, section: 0)
            collectionView.insertItems(at: [headIndexPath])
            
            let cell = collectionView.cellForItem(at: headIndexPath) as! LRUInfoCell
            cell.setInfoText(key: key, text: textView.text)
            keyForCell[key] = textView.text
            
            if count > cacheLRU.getCapacity() {
                collectionEvict()
            }
        }
    }
    
    func collectionGet(key: Int) {
        if let _ = keyForCell[key] {
            for item in 0..<count - 1{
                let indexPath = IndexPath(item: item, section: 0)
                let cell = collectionView.cellForItem(at: indexPath) as! LRUInfoCell
                if let cellKey = cell.key {
                    if cellKey == key {
                        let headIndexPath = IndexPath(item: count - 1, section: 0)
                        collectionView.moveItem(at: indexPath, to: headIndexPath)
                        break
                    }
                }
            }
        }
        else {
            print("No such item")
        }
    }
    
    func collectionRemove(key: Int) {
        if let _ = keyForCell[key] {
            for item in 0..<count - 1{
                let indexPath = IndexPath(item: item, section: 0)
                let cell = collectionView.cellForItem(at: indexPath) as! LRUInfoCell
                if let cellKey = cell.key {
                    if cellKey == key {
                        count -= 1
                        collectionView.deleteItems(at: [indexPath])
                        keyForCell[key] = nil
                        break
                    }
                }
            }
        }
        else {
            print("No such item")
        }
    }
    
    func collectionEvict() {
        count -= 1
        
        if count > 0 {
            let indexPath = IndexPath(item: 0, section: 0)
            let cell = collectionView.cellForItem(at: indexPath) as! LRUInfoCell
            keyForCell[cell.key!] = nil
            collectionView.deleteItems(at: [indexPath])
        }
    }
    
    func createCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets.init(top: 150, left: 0, bottom: 0, right: 0)
        collectionView.register(LRUInfoCell.self, forCellWithReuseIdentifier: "InfoCell")
        collectionView.register(LRUSectionCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        collectionView.register(LRUSectionCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "Footer")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count//cacheLRU.listCount()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfoCell", for: indexPath) as! LRUInfoCell
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath)
                as! LRUSectionCell
            cell.titleLabel.text = "Tail"
            return cell
        case UICollectionView.elementKindSectionFooter:
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath) as! LRUSectionCell
            cell.titleLabel.text = "Head"
            return cell
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 30)
    }
}


