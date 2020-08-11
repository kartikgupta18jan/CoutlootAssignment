//
//  ProductCategoryResModel.swift
//  Assigment
//
//  Created by Mahima Gupta on 8/6/20.
//  Copyright © 2020 Kartik Gupta. All rights reserved.
//

import UIKit;
import ObjectMapper;

class ProductCategoryResModel: NSObject, Mappable {
    var categoryId:Int?
    var categoryName: String?
    var categoryString: String?
    
    override init() {
        
    }
    
    required init(map: Map) {
        
    }
    
    func mapping(map: Map) {
        categoryId <- map["categoryId"];
        categoryName <- map["categoryName"];
        categoryString <- map["categoryString"];
        
    }
}

