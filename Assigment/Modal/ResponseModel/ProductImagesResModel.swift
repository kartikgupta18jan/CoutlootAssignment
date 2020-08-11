//
//  ProductImagesResModel.swift
//  Assigment
//
//  Created by Mahima Gupta on 8/5/20.
//  Copyright © 2020 Kartik Gupta. All rights reserved.
//

import UIKit;
import ObjectMapper;

class ProductImagesResModel: NSObject, Mappable {
    var mainImages:[String]?
    var thumbImages: [String]?
    var submittedImages:[String]?
    
    override init() {
        
    }
    
    required init(map: Map) {
        
    }
    
    func mapping(map: Map) {
        mainImages <- map["mainImages"];
        thumbImages <- map["thumbImages"];
        submittedImages <- map["submittedImages"];
    }
}

