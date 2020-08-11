 
import UIKit
import ObjectMapper
import SwiftyJSON

class UserServices : NSObject {
    
    //GET DATA FOR PRODUCT LIST
    func GetProductListData(callback: @escaping (Bool, RequestOutcome?, String?,Bool)->Void){
        Service.getRequest(.ProductList) { (response, isinternet) in
            if(response.isSuccess()){
                callback(true, response,response.message,isinternet);
            }else{
                callback(false,nil,response.message,isinternet);
            }
        }
    }
   
    //GET DATA FOR PRODUCTDETAIL
    func GetProductDetailData(callback: @escaping (Bool, RequestOutcome?, String?,Bool)->Void){
        Service.getRequest(.ProductDetail) { (response, isinternet) in
            if(response.isSuccess()){
                callback(true, response,response.message,isinternet);
            }else{
                callback(false,nil,response.message,isinternet);
            }
        }
    }
   
}
