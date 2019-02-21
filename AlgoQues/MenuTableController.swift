//
//  MenuTableController.swift
//  LineQues
//
//  Created by Ong Wei Yap on 12/2/19.
//  Copyright © 2019 Ong Wei Yap. All rights reserved.
//

enum Menu: String {
    case maxOfThree
    case oneOfTwo
    case maze
    case LRU
    case timeline
}

import UIKit

class MenuTableController: UITableViewController {

    var menuItems: [Menu] = [.maxOfThree, .oneOfTwo, .maze, .LRU, .timeline]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Menu"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK: Tableview delegate and datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = menuItems[indexPath.row].rawValue
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = menuItems[indexPath.row]
        
        switch item {
        case .maxOfThree:
            let vc = MaxOfThreeCollectionController(collectionViewLayout: UICollectionViewFlowLayout())
            navigationController?.pushViewController(vc, animated: true)
        case .oneOfTwo:
            let vc = OneOfTwoCollectionController(collectionViewLayout: UICollectionViewFlowLayout())
            navigationController?.pushViewController(vc, animated: true)
        case .maze:
            let vc = MazeCollectionController(collectionViewLayout: UICollectionViewFlowLayout())
            navigationController?.pushViewController(vc, animated: true)
        case .LRU:
            let vc = LRUCollectionController(collectionViewLayout: UICollectionViewFlowLayout())
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}











































