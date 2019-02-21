//
//  MaxOfThreeCollectionController.swift
//  LineQues
//
//  Created by Ong Wei Yap on 12/2/19.
//  Copyright © 2019 Ong Wei Yap. All rights reserved.
//

import UIKit

class MaxOfThreeCollectionController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.textColor = .darkText
        textView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.keyboardType = .numbersAndPunctuation
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    var inputArray = [Int]()
    var currentItemIndex = 0
    var nextItemIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Max of Three"
        let getInputButton = UIBarButtonItem(title: "Input", style: .plain, target: self, action: #selector(getInputButtonPressed))
        let sortButton = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(sortButtonPressed))
        navigationItem.rightBarButtonItems = [sortButton, getInputButton]
        
        createTextView()
        createCollectionView()
    }
    
    @objc private func getInputButtonPressed() {
        guard let text = textView.text, text.count > 0 else { return }
        view.endEditing(true)
        currentItemIndex = 0
        nextItemIndex = 0
        let textArray = text.split(separator: " ")
        inputArray = textArray.map({ Int($0) ?? 0 })
        collectionView.reloadData()
    }
    
    @objc private func sortButtonPressed() {
        if inputArray.count < 3 { return }
        sortArray()
    }
    
    private func sortArray() {
        nextItemIndex += 1
        
        if nextItemIndex >= inputArray.count {
            currentItemIndex += 1
            
            if currentItemIndex >= inputArray.count - 1 { //THE END
                print(inputArray)
                displayAnswer()
                return
            }
            else {
                nextItemIndex = currentItemIndex + 1
            }
        }
        
        let firstItem = inputArray[currentItemIndex]
        let nextItem = inputArray[nextItemIndex]
        
        if nextItem > firstItem {
            let temp = nextItem
            inputArray[nextItemIndex] = firstItem
            inputArray[currentItemIndex] = temp
            
            animateSorting()
        }
        else {
            sortArray()
        }
    }
    
    private func animateSorting() {
        collectionView.performBatchUpdates({
            let initial = IndexPath(item: currentItemIndex, section: 0)
            let next = IndexPath(item: nextItemIndex, section: 0)
            self.collectionView.moveItem(at: initial, to: next)
        }) { (_) in
            let initial = IndexPath(item: self.currentItemIndex, section: 0)
            let tempNext = self.nextItemIndex - 1
            if tempNext > 0 {
                let next2 = IndexPath(item: tempNext, section: 0)
                self.collectionView.moveItem(at: next2, to: initial)
            }
            self.sortArray()
        }
    }
    
    private func displayAnswer() {
        let first = inputArray[0]
        let second = inputArray[1]
        let third = inputArray[2]
        
        let result = first * second * third
        
        let alert = UIAlertController(title: "Result", message: String(result), preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    private func createTextView() {
        view.addSubview(textView)
        textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        textView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 8).isActive = true
        textView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -8).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    private func createCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(MaxOfThreeCell.self, forCellWithReuseIdentifier: "MaxOfThreeCell")
        collectionView.contentInset = UIEdgeInsets(top: 100, left: 16, bottom: 0, right: 16)
    }
    
    //MARK: CollectionView Delegate and Datasource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return inputArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MaxOfThreeCell", for: indexPath) as! MaxOfThreeCell
        cell.titleLabel.text = String(inputArray[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
}
