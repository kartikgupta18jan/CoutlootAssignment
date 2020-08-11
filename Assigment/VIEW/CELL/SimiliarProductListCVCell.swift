//
//  SimiliarProductListCVCell.swift
//  ASSIGNMENT
//
//  Created by Mahima Gupta on 10/28/19.
//  Copyright © 2019 Kartik Gupta. All rights reserved.
//

import UIKit

class SimiliarProductListCVCell: UICollectionViewCell {
    @IBOutlet var lblProductName : UILabel!
    @IBOutlet var lblCurrentPrice : UILabel!
    @IBOutlet var lblOldPrice : UILabel!
    @IBOutlet var lblPercentageOff : UILabel!
    @IBOutlet var btnWishlist : UIButton!
    @IBOutlet var imgProduct : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
