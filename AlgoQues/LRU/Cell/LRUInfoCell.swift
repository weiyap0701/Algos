//
//  LRUInfoCell.swift
//  AlgoQues
//
//  Created by Ong Wei Yap on 21/2/19.
//  Copyright © 2019 Ong Wei Yap. All rights reserved.
//

import UIKit

class LRUInfoCell: UICollectionViewCell {
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var key: Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createView() {
        backgroundColor = UIColor(red: 136/255, green: 116/255, blue: 163/255, alpha: 1)
        
        addSubview(infoLabel)
        infoLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        infoLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        infoLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
    }
    
    func setInfoText(key: Int, text: String) {
        self.key = key
        infoLabel.text = "\(key): \(text)"
    }
}

