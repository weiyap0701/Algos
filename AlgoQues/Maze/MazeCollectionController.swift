//
//  MazeCollectionController.swift
//  LineQues
//
//  Created by Ong Wei Yap on 19/2/19.
//  Copyright © 2019 Ong Wei Yap. All rights reserved.
//

import UIKit

enum CellType: Character {
    case Empty = "O"
    case Wall = "|"
    case Start = "S"
    case Goal = "G"
    case Path = "P"
}

class MazeCollectionController: UICollectionViewController {
    
    typealias Maze = [[CellType]]
    
    var maze: Maze!
    var startPoint: MazePoint!
    var goalPoint: MazePoint!
    
    var walkedPoints = Set<ShortestPathPoint>()
    var exploredPoints: [ShortestPathPoint]!
    
    var currentShortestPathIndex = 0
    var shortestPath = [MazePoint]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNavBar()
        createMaze()
        createCollectionView()
    }
    
    //MARK: Method
    private func createNavBar() {
        navigationItem.title = "Maze"
        let findButton = UIBarButtonItem(title: "Find Path", style: .plain, target: self, action: #selector(findPath))
        let restartButton = UIBarButtonItem(title: "Restart", style: .plain, target: self, action: #selector(restartPath))
        navigationItem.rightBarButtonItems = [findButton, restartButton]
    }
    
    @objc private func findPath() {
        if startPoint == nil || goalPoint == nil {
            return
        }
        exploredPoints = [ShortestPathPoint(point: startPoint)]
        startFindingPath()
    }
    
    @objc private func restartPath() {
        createMaze()
        collectionView.reloadData()
    }
    
    private func createMaze() {
        maze = generateMaze(rows: 10, columns: 10, chancesOfWall: 0.2)
        startPoint = nil
        goalPoint = nil
        walkedPoints.removeAll()
        shortestPath.removeAll()
        currentShortestPathIndex = 0
        printMaze(maze)
    }
    
    private func generateMaze(rows: Int, columns: Int, chancesOfWall: Double) -> Maze {
        // create a maze with all empty space
        var maze: Maze = Maze(repeating: [CellType](repeating: .Empty, count: columns), count: rows)
        // insert walls
        for row in 0..<rows {
            for col in 0..<columns {
                if drand48() < chancesOfWall {
                    maze[row][col] = .Wall
                }
            }
        }
        return maze
    }
    
    private func printMaze(_ maze: Maze) {
        for i in 0..<maze.count {
            print(String(maze[i].map{ $0.rawValue }))
        }
    }
    
    private func startFindingPath() {
        //loop through all of the explored points
        while !exploredPoints.isEmpty {
            
            //add explored point to walked points as we're about to walk it
            let currentStep = exploredPoints.remove(at: 0)
            walkedPoints.insert(currentStep)
            
            //reached, print all the steps backward
            if currentStep.point == goalPoint {
                var step: ShortestPathPoint? = currentStep
                while step != nil {
                    print("Position: \(step!.point), G: \(step!.gScore), H: \(step!.hScore), F: \(step!.fScore)")
                    
                    if step!.point != startPoint && step!.point != goalPoint {
                        maze[step!.point.row][step!.point.col] = .Path
                    }
                    shortestPath.append(step!.point)
                    step = step!.parent
                }
                shortestPath = shortestPath.reversed()
                animateReloading()
                return
            }
            
            //get walkable points from current point
            let walkablePoints = getWalkablePathOfCurrentPoint(maze: maze, currentPoint: currentStep.point)
            
            //loop through all walkable points
            for point in walkablePoints {
                let walkablePoint = ShortestPathPoint(point: point)
                
                //if the walkable point has already been walked before, ignore it
                if walkedPoints.contains(walkablePoint) {
                    continue
                }
                
                //set moveScore to 1 as it takes 1 step from point to point
                let moveScore = 1
                
                //check if the walkable point is in the explored points
                var existingIndex: Int?
                for (index, point) in exploredPoints.enumerated() {
                    if point == walkablePoint {
                        existingIndex = index
                        break
                    }
                }
                
                //if walkable point is in explored points, see which of them has the greater gScore, if current step has smaller gScore,
                //set the parent of exploredPoint to new parent (current step) as the old parent requires more steps (higher gScore) to reach to explored point
                if let tempIndex = existingIndex {
                    let exploredPoint = exploredPoints[tempIndex]
                    if currentStep.gScore + moveScore < exploredPoint.gScore {
                        exploredPoint.setParent(parent: currentStep, withMoveScore: moveScore)
                        exploredPoints.remove(at: tempIndex)
                        insertToExploredPoint(point: exploredPoint, inExploredPoints: &exploredPoints)
                    }
                } else {
                    //if walkable point has not been explored, insert it to explored point
                    walkablePoint.setParent(parent: currentStep, withMoveScore: moveScore)
                    walkablePoint.hScore = getHScoreFromPoint(fromPoint: walkablePoint.point, toPoint: goalPoint)
                    insertToExploredPoint(point: walkablePoint, inExploredPoints: &exploredPoints)
                }
            } //End of walkable for loops
        } //End of while loops
    }
    
    private func getWalkablePathOfCurrentPoint(maze: Maze, currentPoint: MazePoint) -> [MazePoint] {
        var walkablePoints: [MazePoint] = [MazePoint]()
        if (currentPoint.row + 1 < maze.count) && (maze[currentPoint.row + 1][currentPoint.col] != .Wall) {
            walkablePoints.append(MazePoint(row: currentPoint.row + 1, col: currentPoint.col))
        }
        if (currentPoint.row - 1 >= 0) && (maze[currentPoint.row - 1][currentPoint.col] != .Wall) {
            walkablePoints.append(MazePoint(row: currentPoint.row - 1, col: currentPoint.col))
        }
        if (currentPoint.col + 1 < maze[0].count) && (maze[currentPoint.row][currentPoint.col + 1] != .Wall) {
            walkablePoints.append(MazePoint(row: currentPoint.row, col: currentPoint.col + 1))
        }
        if (currentPoint.col - 1 >= 0) && (maze[currentPoint.row][currentPoint.col - 1] != .Wall) {
            walkablePoints.append(MazePoint(row: currentPoint.row, col: currentPoint.col - 1))
        }
        
        return walkablePoints
    }
    
    private func insertToExploredPoint(point: ShortestPathPoint, inExploredPoints exploredPoints: inout [ShortestPathPoint]) {
        exploredPoints.append(point)
        exploredPoints.sort { $0.fScore <= $1.fScore }
    }
    
    private func getHScoreFromPoint(fromPoint: MazePoint, toPoint: MazePoint) -> Int {
        return abs(toPoint.col - fromPoint.col) + abs(toPoint.row - fromPoint.row)
    }
    
}








