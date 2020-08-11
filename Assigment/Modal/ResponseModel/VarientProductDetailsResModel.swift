//
//  VarientProductDetailsResModel.swift
//  Assigment
//
//  Created by Mahima Gupta on 8/5/20.
//  Copyright © 2020 Kartik Gupta. All rights reserved.
//

import UIKit;
import ObjectMapper;

class VarientProductDetailsResModel: NSObject, Mappable {
    var labelPrice:Int?
    var listedPrice: Int?
    var percentOff: Int?
    var commision:Int?
    var userEarning:Int?
    
    override init() {
        
    }
    
    required init(map: Map) {
        
    }
    
    func mapping(map: Map) {
        labelPrice <- map["labelPrice"];
        listedPrice <- map["listedPrice"];
        percentOff <- map["percentOff"];
        commision <- map["commision"];
        userEarning <- map["userEarning"];
    }
}
