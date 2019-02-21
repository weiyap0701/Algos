//
//  MazeCollectionController+CollectionView.swift
//  LineQues
//
//  Created by Ong Wei Yap on 20/2/19.
//  Copyright © 2019 Ong Wei Yap. All rights reserved.
//

import UIKit

extension MazeCollectionController: UICollectionViewDelegateFlowLayout {
    
    func createCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(MazeCell.self, forCellWithReuseIdentifier: "MazeCell")
    }
    
    func animateReloading() {
        if currentShortestPathIndex == shortestPath.count {
            return
        }
        let point = shortestPath[currentShortestPathIndex]
        let row = point.row * 10
        let indexPathItem = row + point.col
        let indexPath = IndexPath(item: indexPathItem, section: 0)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.collectionView.reloadItems(at: [indexPath])
            self.currentShortestPathIndex += 1
            self.animateReloading()
        }
    }
    
    private func getRowAndCol(withIndexPath indexPath: IndexPath) -> MazePoint {
        let row = Int(indexPath.item / 10)
        let col = indexPath.item % 10
        return MazePoint(row: row, col: col)
    }
    
    //MARK: Collection view datasource and delegate
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MazeCell", for: indexPath) as! MazeCell
        
        let tempPoint = getRowAndCol(withIndexPath: indexPath)
        let mazeType = maze[tempPoint.row][tempPoint.col]
        cell.mazeType = mazeType
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if startPoint == nil {
            let point = getRowAndCol(withIndexPath: indexPath)
            startPoint = MazePoint(row: point.row, col: point.col)
            maze[point.row][point.col] = .Start
            collectionView.reloadItems(at: [indexPath])
        }
        else if goalPoint == nil {
            let point = getRowAndCol(withIndexPath: indexPath)
            goalPoint = MazePoint(row: point.row, col: point.col)
            maze[point.row][point.col] = .Goal
            collectionView.reloadItems(at: [indexPath])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width / 10
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


