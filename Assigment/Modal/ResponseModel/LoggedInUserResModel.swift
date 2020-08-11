//
//  LoggedInUserResModel.swift
//  Assigment
//
//  Created by Mahima Gupta on 8/5/20.
//  Copyright © 2020 Kartik Gupta. All rights reserved.
//

import UIKit;
import ObjectMapper;

class LoggedInUserResModel: NSObject, Mappable {
    var inCart:Int?
    var inWishlist: Int?
    var isFollowing: Int?

    override init() {
        
    }
    
    required init(map: Map) {
        
    }
    
    func mapping(map: Map) {
        inCart <- map["inCart"];
        inWishlist <- map["inWishlist"];
        isFollowing <- map["isFollowing"];

    }
}

