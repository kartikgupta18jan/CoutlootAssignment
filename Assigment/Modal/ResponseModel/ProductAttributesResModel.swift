//
//  ProductAttributesResModel.swift
//  Assigment
//
//  Created by Mahima Gupta on 8/6/20.
//  Copyright © 2020 Kartik Gupta. All rights reserved.
//

import UIKit;
import ObjectMapper;

class ProductAttributesResModel: NSObject, Mappable {
    var key:String?
    var value: String?
    
    override init() {
        
    }
    
    required init(map: Map) {
        
    }
    
    func mapping(map: Map) {
        key <- map["key"];
        value <- map["value"];
        
    }
}


