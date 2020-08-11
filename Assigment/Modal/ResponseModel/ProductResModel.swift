//
//  ProductResModel.swift
//  Assignment
//

import UIKit;
import ObjectMapper;

class ProductResModel: NSObject, Mappable {
    var productId:Int?
    var status: String?
    var productType: String?
    
    var quantity: Int?
    var sellerDetails:SellerDetailsResModel?
    var images:ProductImagesResModel?
    var details: ProductDetailsResModel?;
    var productCount: Int?;
    var varientCount:Int?
    var collection:String?
    var listedOn: String?
    var liveOn: String?
    var serviceType: String?
    var uplodedBy:Int?
    var assured: Int?
    var crossBorder:Int?
    var offer:Int?
    var loggedInUser: LoggedInUserResModel?;
    var productRating: Int?;
    var availableOffers: [String]?;
    var terms: [String]?;
    var moreColors:[ProductDetailsMoreColorResModel]?
    var footer:[String]?
    var category: ProductCategoryResModel?;
    var videoSale: String?;
   
    override init() {
        
    }
    
    required init(map: Map) {
        
    }
    
    func mapping(map: Map) {
        assured <- map["assured"];
        crossBorder <- map["crossBorder"];
        category <- map["category"];
        videoSale <- map["videoSale"];
        moreColors <- map["moreColors"];
        footer <- map["footer"];
        availableOffers <- map["availableOffers"];
        terms <- map["terms"];
        productType <- map["productType"];
        productId <- map["productId"];
        status <- map["status"];
        quantity <- map["quantity"];
        sellerDetails <- map["sellerDetails"];
        images <- map["images"];
        details <- map["details"];
        productCount <- map["productCount"];
        varientCount <- map["varientCount"]
        collection <- map["collection"];
        listedOn <- map["listedOn"];
        liveOn <- map["liveOn"];
        serviceType <- map["serviceType"];
        uplodedBy <- map["uplodedBy"];
        offer <- map["offer"];
        loggedInUser <- map["loggedInUser"];
        productRating <- map["productRating"]
    }
}

