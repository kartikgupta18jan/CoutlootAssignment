

import UIKit
import SDWebImage

class RootViewController: UIViewController{

    internal let  userService       =  UserServices()
    internal let  commonFunction    =  CommonFunction()
    internal let  constant          =  Constant()
    
    func showNormalAlert(title : String!, msg : String!){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            alert.dismiss(animated: true, completion: nil)
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertMsg(title : String!, msg : String,arrAction: NSArray!){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showActivityIndicator() {
            self.view.makeToastActivity(message: "Loading...")
           // UIApplication.shared.beginIgnoringInteractionEvents();
    }
    
    func hideActivityIndicator(){
            self.view.hideToastActivity()
            //UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    func shareData(url:String,imageUrl:String){
        let firstActivityItem = "Download the best Gardening Consultant App."
        let secondActivityItem : NSURL = NSURL(string: url)!
        let image = UIImageView()
        image.sd_setImage(with: URL(string: imageUrl), placeholderImage: constant.IMGNOIMAGE)
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [firstActivityItem, secondActivityItem, image.image ?? UIImage()], applicationActivities: nil)
        
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            activityViewController.excludedActivityTypes = [
                UIActivity.ActivityType.postToWeibo,
                UIActivity.ActivityType.print,
                UIActivity.ActivityType.assignToContact,
                UIActivity.ActivityType.saveToCameraRoll,
                UIActivity.ActivityType.addToReadingList,
                UIActivity.ActivityType.postToFlickr,
                UIActivity.ActivityType.postToVimeo,
                UIActivity.ActivityType.postToTencentWeibo
            ]
            break
        case .pad:
            activityViewController.popoverPresentationController?.sourceView = self.view
            break
        default:
            break
        }
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func ratingViewComponents(ratingV:FloatRatingView){
        ratingV.emptyImage = constant.REVIEWIMAGEGRAY
        ratingV.fullImage = constant.REVIEWIMAGEYELLOW
        ratingV.contentMode = UIView.ContentMode.scaleAspectFit
        ratingV.maxRating = 5
        ratingV.minRating = 0
        ratingV.rating = 2.5
        ratingV.editable = false
        ratingV.halfRatings = true
        ratingV.floatRatings = false
    }
    
}
