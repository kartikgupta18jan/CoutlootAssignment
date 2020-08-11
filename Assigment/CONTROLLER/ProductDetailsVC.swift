//
//  ProductDetailsVC.swift
//  Asssignment
//
//  Created by Mahima Gupta on 11/2/19.
//  Copyright © 2019 Kartik Gupta. All rights reserved.
//

import UIKit

//Product Size CollectionView Model
class SizeChartModel {
    var name: String = ""
    var isSelected: Bool = false
    init(name: String) {
        self.name = name
    }
}

//Product Footer/Delivery CollectionView Model
class DeliveryModel {
    var detail: String = ""
    var imgDelivery: UIImage?
    init(detail: String,imgDelivery:UIImage) {
        self.detail = detail
        self.imgDelivery = imgDelivery
    }
}

class ProductDetailsVC: RootViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource {
    
    //Outlets
    @IBOutlet var vLive : UIView!
    @IBOutlet var lblOldPrice : UILabel!
    @IBOutlet var lblSize : UILabel!
    @IBOutlet var lblColor : UILabel!
    @IBOutlet var lblCondition : UILabel!
    @IBOutlet var lblLocation : UIButton!
    @IBOutlet var lblSellerName : UILabel!
    @IBOutlet var imgSeller : UIImageView!
    @IBOutlet var lblFlaws : UILabel!
    @IBOutlet var lblMaterial : UILabel!
    @IBOutlet var lblBrand : UILabel!
    @IBOutlet var lblDescription : UILabel!
    @IBOutlet var lblNewPrice : UILabel!
    @IBOutlet var lblPercentageOff : UILabel!
    @IBOutlet var lblReducedPrice : UILabel!
    @IBOutlet var lblTitle : UILabel!
    @IBOutlet var imgProduct : UIImageView!
    @IBOutlet var lblNoData : UILabel!
    
    //Outlet For collection view and tableview
    @IBOutlet var collectionMoreColor : UICollectionView!
    @IBOutlet var collectionSimiliarProduct : UICollectionView!
    @IBOutlet var collectionSellerProduct : UICollectionView!
    @IBOutlet var collectionFooeter : UICollectionView!
    @IBOutlet weak var tblVDelivery: UITableView!
    @IBOutlet var collectionSize : UICollectionView!
    
    //Var array objects for data
    var modelProductDetails = ProductResModel()
    var arrSize = [SizeChartModel]()
    var arrDelivery = [DeliveryModel]()
    var arrFooter = [String]()
    var arrOffer = [DeliveryModel]()
    var arrSimiliarProduct:[ProductResModel]?
    
    //Rating view outlet
    @IBOutlet weak var ratingView: FloatRatingView!

    override func viewDidLoad() {
        super.viewDidLoad()
 
        //UI VALUES
        self.uiValueData()
        
        //Lable for no record found
        self.lblNoData.isHidden = true
    }
    
    func uiValueData(){
        //rating view components
        self.ratingViewComponents(ratingV: ratingView)
        
        //call api
        self.callProductDetailApi()
        
        //register tableview and collection view cell
        self.RegisterCell()
        
        //Set Border color for vLive
        vLive.layer.borderColor = constant.WHITECOLOR.cgColor
        vLive.layer.borderWidth = 1
        
        //Set static data for Size Array
        arrSize = [
            SizeChartModel(name: constant.SIZESMALL),
            SizeChartModel(name: constant.SIZEMEDIUM),
            SizeChartModel(name: constant.SIZELARGE),
        ]
    }
    
    func RegisterCell(){
        collectionSimiliarProduct.register(UINib(nibName: constant.SIMILIARPRODUCTNIB, bundle: nil), forCellWithReuseIdentifier: constant.SIMILIARPRODUCTNIB)
        collectionSellerProduct.register(UINib(nibName: constant.SIMILIARPRODUCTNIB, bundle: nil), forCellWithReuseIdentifier: constant.SIMILIARPRODUCTNIB)
        tblVDelivery.register(UINib(nibName: constant.DELIVERYPRODUCTNIB, bundle: nil), forCellReuseIdentifier: constant.DELIVERYPRODUCTNIB)
        let nib = UINib(nibName: constant.HEADERPRODUCTNIB, bundle: nil)
        self.tblVDelivery.register(nib, forHeaderFooterViewReuseIdentifier: constant.HEADERPRODUCTNIB)
        tblVDelivery.rowHeight = UITableView.automaticDimension;
        tblVDelivery.estimatedRowHeight = 44.0;
        self.tblVDelivery.contentInset = UIEdgeInsets(top: -36, left: 0, bottom: -20, right: 0);
    }
    
    //Api calling for product DATA
    func callProductDetailApi() {
        if CommonFunction.sharedInstance.isConnectedToNetwork(){
            self.showActivityIndicator()
            userService.GetProductDetailData(callback: callbackMapDetails)
        }else{
            self.showNormalAlert(title: kProjectName, msg: Message.kNoInterNet.rawValue)
        }
    }
    func callbackMapDetails(flag : Bool, response: RequestOutcome?, msg: String?,isinternet : Bool ) {
        self.hideActivityIndicator()
        if flag{
            if response?.product != nil{
                modelProductDetails = response?.product ?? ProductResModel()
                self.SetPrdoctDetailsValues()
            }else{
                self.lblNoData.isHidden = false
            }
        }else{
            self.view.makeToast(message: msg ?? Message.kNoInterNet.rawValue, duration: 1.0, position: HRToastPositionCenter as AnyObject)
        }
    }
    
    func SetPrdoctDetailsValues(){
        //Start Timer
        self.startOtpTimer()
        
        let priceData = modelProductDetails.details?.variants?[0].priceDetails ?? VarientProductDetailsResModel()
        lblOldPrice.text = "₹ \(priceData.labelPrice ?? 0)"
        lblNewPrice.text = "₹ \(priceData.listedPrice ?? 0)"
        lblPercentageOff.text = "\(priceData.percentOff ?? 0) %"
        lblReducedPrice.text = modelProductDetails.details?.variants?[0].negotiated?.offerText ?? ""
        lblTitle.text = modelProductDetails.details?.title ?? ""
        modelProductDetails.moreColors?[0].isSelected = true
        arrSize[1].isSelected = true
        
        self.ratingView.rating = 4.9
        
        self.lblDescription.text = modelProductDetails.details?.des ?? ""
        
        self.lblSize.text = "Standard"
        self.lblColor.text = "Blue"
        self.lblBrand.text = modelProductDetails.details?.brand ?? ""
        self.lblCondition.text = modelProductDetails.details?.condition ?? ""
        self.lblFlaws.text = "Some smple text here"
        self.lblMaterial.text = "Coton"
        
        
        self.lblSellerName.text = modelProductDetails.sellerDetails?.name ?? ""
        self.lblLocation.setTitle(modelProductDetails.sellerDetails?.city ?? "", for: .normal)
        
        arrDelivery = [
            DeliveryModel(detail: modelProductDetails.terms?[0] ?? "", imgDelivery: constant.IMGDELIVERY!),
            DeliveryModel(detail: modelProductDetails.terms![1], imgDelivery: constant.IMGMONEY!),
            DeliveryModel(detail: modelProductDetails.terms![2], imgDelivery: constant.IMGRETURN!)
        ]
        arrOffer = [
            DeliveryModel(detail: modelProductDetails.availableOffers![0], imgDelivery: constant.IMGDiscount!),
        ]
        arrFooter = modelProductDetails.footer ?? [String]()
        DispatchQueue.global().async {
            let str = "\(self.modelProductDetails.images?.mainImages?[0] ?? "")"
            let strSeller = "\(self.modelProductDetails.sellerDetails?.profilePic ?? "")"
            DispatchQueue.main.async {
                self.imgProduct.sd_setImage(with: URL(string: str), placeholderImage: self.constant.IMGNOIMAGE)
                self.imgSeller.sd_setImage(with: URL(string: strSeller), placeholderImage: self.constant.IMGNOIMAGE)
            }
        }
        
        //Set tableview and collection view deletgate/datasource and reload data
        tblVDelivery.delegate = self
        tblVDelivery.dataSource = self
        tblVDelivery.reloadData()
        collectionSize.reloadData()
        collectionMoreColor.delegate = self
        collectionMoreColor.dataSource = self
        collectionMoreColor.reloadData()
        collectionSellerProduct.reloadData()
        collectionFooeter.reloadData()
    }
    
    //Set count for different collection view items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if collectionView == collectionMoreColor{
            return modelProductDetails.moreColors?.count ?? 0
        }else if collectionView == collectionSize{
            return arrSize.count
        }else if collectionView == collectionFooeter{
            return arrFooter.count
        }else{
            return 5
        }
    }
    
    //Set Data values for different collection view items
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionMoreColor{
            guard let cellMoreColor = collectionMoreColor.dequeueReusableCell(withReuseIdentifier: constant.MORECOLORNIB, for: indexPath as IndexPath) as? MoreColorCVCell else{
                return MoreColorCVCell()
            }
            
            let productData = modelProductDetails.moreColors?[indexPath.row] ?? ProductDetailsMoreColorResModel()
            cellMoreColor.lblPrice.text = "₹ \(productData.price ?? 0)"
            
            DispatchQueue.global().async {
                let str = "\(productData.displayImage ?? "")"
                DispatchQueue.main.async {
                    cellMoreColor.imgProduct.sd_setImage(with: URL(string: str), placeholderImage: self.constant.IMGNOIMAGE)
                }
            }
            
            cellMoreColor.btnSelected.addTarget(self, action: #selector(self.btnExpandedTap(sender:)), for: .touchUpInside)
            cellMoreColor.btnSelected.tag = indexPath.row
            if (modelProductDetails.moreColors?[indexPath.row].isSelected == true){
                cellMoreColor.imgProduct.layer.borderColor = constant.REDCOLOR.cgColor
            }else{
                cellMoreColor.imgProduct.layer.borderColor = constant.GRAYCOLOR.cgColor
            }
            return cellMoreColor
        }else if collectionView == collectionSize{
            guard let cellSize = collectionSize.dequeueReusableCell(withReuseIdentifier: constant.SIZEPRODUCTNIB, for: indexPath as IndexPath) as? ProductSizeCVCell
            else{
                return ProductSizeCVCell()
            }
            cellSize.btnSelectedName.setTitle(arrSize[indexPath.row].name, for: .normal)
            cellSize.btnSelectedName.addTarget(self, action: #selector(self.btnSizeTap(sender:)), for: .touchUpInside)
            cellSize.btnSelectedName.tag = indexPath.row
            if (arrSize[indexPath.row].isSelected == true){
                cellSize.btnSelectedName.backgroundColor = constant.BACKGROUNDPINKCOLOR
                cellSize.btnSelectedName.setTitleColor(constant.REDCOLOR, for: .normal)
                cellSize.btnSelectedName.layer.borderColor = constant.REDCOLOR.cgColor
            }else{
                cellSize.btnSelectedName.backgroundColor = constant.WHITECOLOR
                cellSize.btnSelectedName.setTitleColor(constant.LIGHTGRAYCOLOR, for: .normal)
                cellSize.btnSelectedName.layer.borderColor = constant.LIGHTGRAYCOLOR.cgColor
            }
            return cellSize
        }else if collectionView == collectionFooeter{
            guard let cellFooter = collectionFooeter.dequeueReusableCell(withReuseIdentifier: constant.SIZEPRODUCTNIB, for: indexPath as IndexPath) as? ProductSizeCVCell
            else{
                return ProductSizeCVCell()
            }
            DispatchQueue.global().async {
                let str = "\(self.arrFooter[indexPath.row])"
                DispatchQueue.main.async {
                    cellFooter.imgPaymentType.sd_setImage(with: URL(string: str), placeholderImage: self.constant.IMGNOIMAGE)
                }
            }
            return cellFooter
        }else{
            guard let cell = collectionSimiliarProduct.dequeueReusableCell(withReuseIdentifier: constant.SIMILIARPRODUCTNIB, for: indexPath as IndexPath) as? SimiliarProductListCVCell
            else{
                return SimiliarProductListCVCell()
            }
            
            let productData = arrSimiliarProduct?[indexPath.row].details ?? ProductDetailsResModel()
            cell.lblProductName.text = productData.title ?? ""
            cell.lblCurrentPrice.text = "₹\(productData.variants?[0].priceDetails?.listedPrice ?? 0)"
            cell.lblOldPrice.text = "\(productData.variants?[0].priceDetails?.labelPrice ?? 0)"
            cell.lblPercentageOff.text = "\(productData.variants?[0].priceDetails?.percentOff ?? 0)% off"
            
            DispatchQueue.global().async {
                let str = "\(self.arrSimiliarProduct?[indexPath.row].images?.thumbImages?[0] ?? "")"
                DispatchQueue.main.async {
                    cell.imgProduct.sd_setImage(with: URL(string: str), placeholderImage: self.constant.IMGNOIMAGE)
                }
            }
            return cell
        }
    }
    
    //Select/deselct More color items
    @objc func  btnExpandedTap(sender:UIButton){
        for i in 0..<modelProductDetails.moreColors!.count{
            let item  = modelProductDetails.moreColors?[i]
            item?.isSelected  = false
            modelProductDetails.moreColors?[i] = item ?? ProductDetailsMoreColorResModel()
            
        }
        let item  = modelProductDetails.moreColors?[sender.tag]
        item?.isSelected  = true
        modelProductDetails.moreColors?[sender.tag] = item ?? ProductDetailsMoreColorResModel()
        collectionMoreColor.reloadData();
    }
    
    //Select/deselct Product size items
    @objc func  btnSizeTap(sender:UIButton){
        for i in 0..<arrSize.count{
            let item  = arrSize[i]
            item.isSelected  = false
            arrSize[i] = item
            
        }
        let item  = arrSize[sender.tag]
        item.isSelected  = true
        arrSize[sender.tag] = item
        collectionSize.reloadData();
    }
    
    //Set collection view Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var itemWidth = CGFloat()
        if collectionView == collectionMoreColor{
            itemWidth = (collectionMoreColor.bounds.width / 4) - 8
            return CGSize(width: itemWidth, height: CGFloat(90.0))
        }else if collectionView == collectionSize{
            itemWidth = (collectionSize.bounds.width / 4) - 8
            return CGSize(width: itemWidth, height: CGFloat(60.0))
        }else if collectionView == collectionFooeter{
            itemWidth = (collectionFooeter.bounds.width / 3)
            return CGSize(width: itemWidth, height: CGFloat(75.0))
        }else{
            itemWidth = (collectionSimiliarProduct.bounds.width / 2.5)
            return CGSize(width: itemWidth, height: CGFloat(225.0))
        }
       
    }
 
    //Set Number of section in tableview
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //Set Number of rows in tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return arrDelivery.count
        }
        return arrOffer.count
    }
    
    //Set height of header in tableview
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
         return 44;
    }
    
    //Set data forheaderview section in tableview
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        let headerView = self.tblVDelivery.dequeueReusableHeaderFooterView(withIdentifier: constant.HEADERPRODUCTNIB)as! ProductDetailHeaderV
        
        if section == 0{
            headerView.lblProdName.text = constant.HEADERDELIVERY
        }else{
            headerView.lblProdName.text = constant.HEADEROFFER
        }
        return headerView;
    }
    
    //set data for footer tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tblVDelivery.dequeueReusableCell(withIdentifier: constant.DELIVERYPRODUCTNIB, for: indexPath) as? DeliveryTVCell else{
            return DeliveryTVCell()
        }
        var data = [DeliveryModel]()
        if indexPath.section == 0{
            data = arrDelivery
        } else{
            data = arrOffer
        }
        cell.lblDeliveryDes.text = data[indexPath.row].detail
        cell.imageView?.image = data[indexPath.row].imgDelivery ?? UIImage()
        return cell
    }
    
    //GIVE OPTION TO THE USER TO SHARE AND FOLLOW THIS PRODUCT
    @IBAction func btnFollow(_ sender: UIButton) {
         self.shareData(url: modelProductDetails.details?.productUrl ?? "", imageUrl: modelProductDetails.images?.thumbImages?[0] ?? "")
    }
    
    //Drag user to website for this product
    @IBAction func btnLive(_ sender: UIButton) {
        if let url = URL(string: modelProductDetails.details?.productUrl ?? "") {
            UIApplication.shared.open(url)
        }
    }
    
    //Dismiss vc
    @IBAction func btnBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    //Product Countdown
    @IBOutlet private weak var timesSec: UILabel!
    @IBOutlet private weak var timeMin: UILabel!
    @IBOutlet private weak var timeHour: UILabel!
    var timer: Timer?
    var totalTime = Int()
    
    //Start time after getting data for offer
    private func startOtpTimer() {
        let isoDate = modelProductDetails.details?.variants?[0].negotiated?.endTime ?? ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = constant.DATEFORMATE
        let date = dateFormatter.date(from:isoDate) ?? Date()
        
        let currentDate = Date()
        
        let delta = currentDate - date
        self.totalTime = delta.second ?? 0
        
        
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    //Update the time
    @objc func updateTimer() {
        self.timeFormatted(self.totalTime)
        if totalTime != 0 {
            totalTime -= 1  // decrease counter timer
        } else {
            if let timer = self.timer {
                timer.invalidate()
                self.timer = nil
            }
        }
    }
    
    //For get minute,second,hours for different lable
    func timeFormatted(_ totalSeconds: Int) {
        self.timesSec.text = "\(totalSeconds % 60)"
        self.timeMin.text = "\((totalSeconds / 60) % 60)"
        self.timeHour.text = "\((totalSeconds / 3600))"
    }
}
