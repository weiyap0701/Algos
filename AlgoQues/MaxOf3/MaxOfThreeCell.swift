//
//  MaxOfThreeCell.swift
//  LineQues
//
//  Created by Ong Wei Yap on 12/2/19.
//  Copyright © 2019 Ong Wei Yap. All rights reserved.
//

import UIKit

class MaxOfThreeCell: UICollectionViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createView() {
        backgroundColor = UIColor(red: 99/255, green: 172/255, blue: 229/255, alpha: 1)
        
        addSubview(titleLabel)
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
}
