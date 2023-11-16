//
//  TableViewCell.swift
//  test
//
//  Created by Abdullah Asim on 13/11/2023.
//  Copyright © 2023 Abdullah Asim. All rights reserved.
//

import UIKit

protocol ImagePickerDelegate {
    
    func pickImage(row:Int, col:Int)
}

class TableViewCell: UITableViewCell {
    
    var delegate : ImagePickerDelegate?

    var rowNumber = 0
    
    static let cellIdentifier = "tableCell"
    static let nibName = "TableViewCell"
    
    var arr = [UIImage]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: CollectionCell.nibName, bundle: nil), forCellWithReuseIdentifier: CollectionCell.cellIdentifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }

    func loadImages(_ imgNew:[UIImage])
    {
        arr = imgNew
        collectionView.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    @IBAction func addImage(_ sender: UIButton) {
        delegate?.pickImage(row: rowNumber, col:arr.count)
        
    }
    func update(img:UIImage)
    {
        arr.append(img)
        collectionView.reloadData()
    }
    
}

extension TableViewCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.cellIdentifier, for: indexPath) as! CollectionCell
        cell.imageView?.image = arr[indexPath.row]
        
        return cell
    }
    
}

extension TableViewCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 180)
    }
}
