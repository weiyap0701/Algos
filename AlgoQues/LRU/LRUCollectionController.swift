//
//  LRUCollectionController.swift
//  LineQues
//
//  Created by Ong Wei Yap on 20/2/19.
//  Copyright © 2019 Ong Wei Yap. All rights reserved.
//

import UIKit


class LRUCollectionController: UICollectionViewController {
    
    //MARK: UI
    let keyTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .darkText
        textField.backgroundColor = UIColor(white: 0.9, alpha: 1)
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.placeholder = "Enter key..."
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.textColor = .darkText
        textView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    //MARK: Variable
    let cacheLRU = LRU<Int, String>(capacity: 3)
    var keyForCell = [Int: String]()
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNavBar()
        createTextView()
        createCollectionView()
    }

    //MARK: Method
    @objc private func add() {
        guard let key = keyTextField.text, key.count > 0, let intKey = Int(key) else { return }
        collectionAdd(key: intKey)
        cacheLRU.add(withKey: intKey, textView.text)
    }
    
    @objc private func get() {
        guard let key = keyTextField.text, key.count > 0, let intKey = Int(key) else { return }
        collectionGet(key: intKey)
        cacheLRU.get(withKey: intKey)
    }
    
    @objc private func remove() {
        guard let key = keyTextField.text, key.count > 0, let intKey = Int(key) else { return }
        collectionRemove(key: intKey)
        cacheLRU.remove(withKey: intKey)
    }
    
    @objc private func evict() {
        collectionEvict()
        cacheLRU.evict()
    }
    
    private func createNavBar() {
        navigationItem.title = "LRU"
        let addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(add))
        let getButton = UIBarButtonItem(title: "Get", style: .plain, target: self, action: #selector(get))
        let removeButton = UIBarButtonItem(title: "Remove", style: .plain, target: self, action: #selector(remove))
        let evictButton = UIBarButtonItem(title: "Evict", style: .plain, target: self, action: #selector(evict))
        navigationItem.rightBarButtonItems = [addButton, getButton, removeButton, evictButton]
    }
    
    private func createTextView() {
        view.addSubview(keyTextField)
        keyTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        keyTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 8).isActive = true
        keyTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -8).isActive = true
        keyTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        view.addSubview(textView)
        textView.topAnchor.constraint(equalTo: keyTextField.bottomAnchor, constant: 8).isActive = true
        textView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 8).isActive = true
        textView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -8).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
}

