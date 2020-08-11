//
//  SellerDetailsResModel.swift
//  Assigment
//
//  Created by Mahima Gupta on 8/4/20.
//  Copyright © 2020 Kartik Gupta. All rights reserved.
//

import UIKit;
import ObjectMapper;

class SellerDetailsResModel: NSObject, Mappable {
    var userId:Int?
    var name: String?
    var profilePic: String?
    var city:String?
    var role:String?
    var verified: Int?;
    var userSlug: String?;
    
    override init() {
        
    }
    
    required init(map: Map) {
        
    }
    
    func mapping(map: Map) {
        userId <- map["userId"];
        name <- map["name"];
        profilePic <- map["profilePic"];
        city <- map["city"];
        role <- map["role"];
        verified <- map["verified"];
        userSlug <- map["userSlug"];
    }
}


