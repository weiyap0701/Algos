import UIKit

class OneOfTwoCollectionController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
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
        
        navigationItem.title = "One Of Two"
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
        sortArray()
    }
    
    private func sortArray() {
        
        if currentItemIndex == inputArray.count - 1 {
            return
        }
        
        nextItemIndex = currentItemIndex + 1
        let firstItem = inputArray[currentItemIndex]
        let secondItem = inputArray[nextItemIndex]
        let currentIndexPath = IndexPath(item: currentItemIndex, section: 0)
        let nextIndexPath = IndexPath(item: nextItemIndex, section: 0)
        let firstCell = self.collectionView.cellForItem(at: currentIndexPath) as! OneOfTwoCell
        let secondCell = self.collectionView.cellForItem(at: nextIndexPath) as! OneOfTwoCell

        firstCell.setComparingBgColor()
        secondCell.setComparingBgColor()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if firstItem > secondItem {
                self.reloadCell(item: self.currentItemIndex)
            }
            else if firstItem < secondItem {
                self.reloadCell(item: self.nextItemIndex)
            }
            firstCell.setUncomparingBgColor()
            secondCell.setUncomparingBgColor()
            self.currentItemIndex += 1
            self.sortArray()
        }
        
    }
    
    private func reloadCell(item: Int) {
        let indexPath = IndexPath(item: item, section: 0)
        let cell = collectionView.cellForItem(at: indexPath) as! OneOfTwoCell
        cell.setHigherLabelColor()
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
        collectionView.register(OneOfTwoCell.self, forCellWithReuseIdentifier: "OneOfTwoCell")
        collectionView.contentInset = UIEdgeInsets(top: 100, left: 16, bottom: 0, right: 16)
    }
    
    //MARK: CollectionView Delegate and Datasource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return inputArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OneOfTwoCell", for: indexPath) as! OneOfTwoCell
        cell.titleLabel.text = String(inputArray[indexPath.item])
        cell.setLowerLabelColor()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
}
