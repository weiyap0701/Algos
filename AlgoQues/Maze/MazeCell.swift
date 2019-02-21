//
//  MazeCell.swift
//  LineQues
//
//  Created by Ong Wei Yap on 20/2/19.
//  Copyright © 2019 Ong Wei Yap. All rights reserved.
//

import UIKit

class MazeCell: UICollectionViewCell {
    
    var pointLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: Variable
    var mazeType: CellType? {
        didSet {
            if let type = mazeType {
                pointLabel.text = String(type.rawValue)
                switch type {
                case .Start:
                    backgroundColor = UIColor(red: 255/255, green: 190/255, blue: 48/255, alpha: 1)
                case .Goal:
                    backgroundColor = UIColor(red: 255/255, green: 111/255, blue: 105/255, alpha: 1)
                case .Empty:
                    backgroundColor = UIColor(red: 136/255, green: 216/255, blue: 176/255, alpha: 1)
                case .Wall:
                    backgroundColor = UIColor(red: 83/255, green: 104/255, blue: 120/255, alpha: 1)
                case .Path:
                    backgroundColor = UIColor(red: 74/255, green: 145/255, blue: 242/255, alpha: 1)
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Method
    private func createView() {
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.white.cgColor
        
        addSubview(pointLabel)
        pointLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pointLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func setColor() {
        
    }
}
