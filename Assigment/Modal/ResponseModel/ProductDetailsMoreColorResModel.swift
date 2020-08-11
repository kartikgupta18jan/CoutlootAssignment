//
//  ProductDetailsMoreColorResModel.swift
//  Assigment
//
//  Created by Mahima Gupta on 8/6/20.
//  Copyright © 2020 Kartik Gupta. All rights reserved.
//

import UIKit;
import ObjectMapper;

class ProductDetailsMoreColorResModel: NSObject, Mappable {
    var productId:Int?
    var displayImage: String?
    var price: Int?
    var isSelected: Bool = false
    
    override init() {
        
    }
    
    required init(map: Map) {
        
    }
    
    func mapping(map: Map) {
        productId <- map["productId"];
        displayImage <- map["displayImage"];
        price <- map["price"];
        
    }
}
