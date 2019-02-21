//
//  MazePoint.swift
//  LineQues
//
//  Created by Ong Wei Yap on 20/2/19.
//  Copyright © 2019 Ong Wei Yap. All rights reserved.
//


struct MazePoint {
    let row: Int
    let col: Int
    var hashValue: Int {
        return row.hashValue + col.hashValue
    }
}

extension MazePoint: Hashable {
    static func == (lhs: MazePoint, rhs: MazePoint) -> Bool {
        return lhs.row == rhs.row && lhs.col == rhs.col
    }
}
