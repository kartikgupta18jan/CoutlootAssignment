//
//  ProductVarientNegotiatedResModel.swift
//  Assigment
//
//  Created by Mahima Gupta on 8/8/20.
//  Copyright © 2020 Kartik Gupta. All rights reserved.
//

import UIKit;
import ObjectMapper;

class ProductVarientNegotiatedResModel: NSObject, Mappable {
    var price:Int?
    var percentOff: Int?
    var offerText:String?
    var endTime: String?
    
    override init() {
        
    }
    
    required init(map: Map) {
        
    }
    
    func mapping(map: Map) {
        price <- map["price"];
        percentOff <- map["percentOff"];
        offerText <- map["offerText"];
        endTime <- map["endTime"];
    }
}

