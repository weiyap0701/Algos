//
//  ShortestPathPoint.swift
//  LineQues
//
//  Created by Ong Wei Yap on 20/2/19.
//  Copyright © 2019 Ong Wei Yap. All rights reserved.
//


class ShortestPathPoint {
    let point: MazePoint
    var parent: ShortestPathPoint?
    
    var gScore = 0
    var hScore = 0
    var fScore: Int {
        return gScore + hScore
    }
    
    var hashValue: Int {
        return Int(point.col.hashValue / point.row.hashValue)
    }
    
    init(point: MazePoint) {
        self.point = point
    }
    
    func setParent(parent: ShortestPathPoint, withMoveScore moveScore: Int) {
        // The G score is equal to the parent G score + the cost to move from the parent to it
        self.parent = parent
        self.gScore = parent.gScore + moveScore
    }
}

extension ShortestPathPoint: Hashable {
    static func ==(lhs: ShortestPathPoint, rhs: ShortestPathPoint) -> Bool {
        return lhs.point == rhs.point
    }
}
