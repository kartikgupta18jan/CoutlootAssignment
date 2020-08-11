
//
//  RequestOutcome
//  Assignment
//

import UIKit;
import ObjectMapper;

class RequestOutcome: NSObject, Mappable {
    
    var status: Bool?;
    var products: [ProductResModel]?;
    var product: ProductResModel?;
    var message: String?;
    var statusCode:Int?
    var currentPage : Int?
    var nextPage : Int?
    var pageTitle : String?
    var breadcrumbs : String?
    var noPages : Int?
    
    func isSuccess() -> Bool {
        return status == true
    }
    
    override init() {
        
    }
    
    required init(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        status <- map["success"];
        product <- map["product"];
        products <- map["products"];
        message <- map["Message"];
        statusCode <- map["StatusCode"]
        currentPage <- map["currentPage"];
        nextPage <- map["nextPage"];
        pageTitle <- map["pageTitle"];
        breadcrumbs <- map["breadcrumbs"];
        noPages <- map["noPages"];
    }
}


