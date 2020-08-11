import UIKit
import ObjectMapper
import Alamofire

public enum MethodName: String{
    // Start api
    case GetParam                  = "Get"
    case PostParam                 = "Post"
    case NoParam                   = ""
    case ProductList               = "product/list"
    case ProductDetail             = "product/details"
}
class Service: NSObject {
    //Development Url
    fileprivate static let appLinkUrl = "http://dev-gtw1.coutloot.com:20038/";
    fileprivate static func setHeader() -> [String : String] {
        let dictionary = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Accept": "application/json",
           
        ];
        return dictionary;
    }

    
    static func getRequest(_ method: MethodName, callback: @escaping (RequestOutcome,Bool) -> Void) {
        let endPoint = appLinkUrl + method.rawValue;
        if CommonFunction.sharedInstance.isConnectedToNetwork() {
            request(endPoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: setHeader())
                .responseJSON { (response) in
                    print(response.result)
                    requestCallBack(response.result, callback: callback);
            }
        }else{
            callback(RequestOutcome(),false)
        }
        
    }
  
    fileprivate static func requestCallBack(_ result: Result<Any>, callback: (RequestOutcome, Bool) -> Void)  {
        if(result.isSuccess) {
            print(result.value as Any)
            let requestOutcome = Mapper<RequestOutcome>().map(JSONObject: result.value)
            callback(requestOutcome!,true);
            
        } else {
            callback(RequestOutcome(),true);
        }
    }
}
