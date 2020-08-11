//
//  ProductListCVCell.swift
//  ASSIGNMENT
//
//  Created by Mahima Gupta on 10/28/19.
//  Copyright © 2019 Kartik Gupta. All rights reserved.
//

import UIKit

class ProductListCVCell: UICollectionViewCell {
    @IBOutlet var lblProductName : UILabel!
    @IBOutlet var lblCurrentPrice : UILabel!
    @IBOutlet var lblOldPrice : UILabel!
    @IBOutlet var lblPercentageOff : UILabel!
    @IBOutlet var btnWishlist : UIButton!
    @IBOutlet var imgProduct : UIImageView!
    @IBOutlet weak var ratingView: FloatRatingView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Required float rating view params
        self.ratingView.emptyImage = UIImage(named: "gray-star-icon")
        self.ratingView.fullImage = UIImage(named: "ful-star-icon")
        // Optional params
        // self.ratingView.delegate = self
        // self.ratingView.backgroundColor = UIColor.blueColor()
        self.ratingView.contentMode = UIView.ContentMode.scaleAspectFit
        self.ratingView.maxRating = 5
        self.ratingView.minRating = 0
        self.ratingView.rating = 2.5
        self.ratingView.editable = false
        self.ratingView.halfRatings = true
        self.ratingView.floatRatings = false
    }

}
