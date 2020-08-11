//
//  ProductVarientResModel.swift
//  Assigment
//
//  Created by Mahima Gupta on 8/5/20.
//  Copyright © 2020 Kartik Gupta. All rights reserved.
//

import UIKit;
import ObjectMapper;

class ProductVarientResModel: NSObject, Mappable {
    var defaultVal:Int?
    var sku: String?
    var variantName: String?
    var priceDetails:VarientProductDetailsResModel?
    var quantity:Int?
    var negotiated:ProductVarientNegotiatedResModel?
    override init() {
        
    }
    
    required init(map: Map) {
        
    }
    
    func mapping(map: Map) {
        defaultVal <- map["default"];
        sku <- map["sku"];
        variantName <- map["variantName"];
        priceDetails <- map["priceDetails"];
        quantity <- map["quantity"];
        negotiated <- map["negotiated"];
    }
}
