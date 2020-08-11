//
//  ProductDetailsResModel.swift
//  Assigment
//
//  Created by Mahima Gupta on 8/4/20.
//  Copyright © 2020 Kartik Gupta. All rights reserved.
//

import UIKit;
import ObjectMapper;

class ProductDetailsResModel: NSObject, Mappable {
    var title:String?
    var condition: String?
    var des:String?
    var brand: String?
    var variantAttribute:String?
    var variants:[ProductVarientResModel]?
    var productAttributes:[ProductAttributesResModel]?
    var imageRating: Int?;
    var assured: Int?;
    var crossBorder: Int?;
    var meetAndBuy: Int?;
    var productUrl: String?;
    var productSlug: String?;
    
    override init() {
        
    }
    
    required init(map: Map) {
        
    }
    
    func mapping(map: Map) {
        productAttributes <- map["productAttributes"];
        title <- map["title"];
        des <- map["description"];
        condition <- map["condition"];
        brand <- map["brand"];
        variantAttribute <- map["variantAttribute"];
        variants <- map["variants"];
        imageRating <- map["imageRating"];
        assured <- map["assured"];
        crossBorder <- map["crossBorder"];
        meetAndBuy <- map["meetAndBuy"];
        productUrl <- map["productUrl"];
        productSlug <- map["productSlug"];
    }
}
