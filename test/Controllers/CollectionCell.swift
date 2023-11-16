//
//  CollectionCell.swift
//  test
//
//  Created by Abdullah Asim on 13/11/2023.
//  Copyright © 2023 Abdullah Asim. All rights reserved.
//

import UIKit

class CollectionCell: UICollectionViewCell {

    static let cellIdentifier = "collectionCell"
    static let nibName = "CollectionCell"
    
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .red
        // Initialization code
    }

}
