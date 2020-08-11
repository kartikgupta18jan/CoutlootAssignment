//
//  ImageRoundV.swift
//  Assigment
//
//  Created by Mahima Gupta on 8/8/20.
//  Copyright © 2020 Kartik Gupta. All rights reserved.
//

import UIKit


class ImageRoundV: UIImageView {
    
    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width:0.5,height: 4.0); //Here your control your spread
        self.layer.shadowOpacity = 0.15
        self.layer.shadowRadius = 5.0 //Here your control your blur
    }
    
}

