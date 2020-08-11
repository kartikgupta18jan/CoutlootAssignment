//
//  ProductListVC.swift
//  Asssignment
//
//  Created by Mahima Gupta on 11/2/19.
//  Copyright © 2019 Kartik Gupta. All rights reserved.
//

import UIKit
class ProductListVC: RootViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIPickerViewDelegate, UIPickerViewDataSource {

    //Outlets
    @IBOutlet var lblNoData : UILabel!
    @IBOutlet var lblTitle : UILabel!
    @IBOutlet var btnAssured : UISwitch!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet var collectionProductList : UICollectionView!
    
    //Var array objects for data
    var arrAllProductList = [ProductResModel]()
    var arrAssuredPrductsList = [ProductResModel]()
    var arrProductList = [ProductResModel]()

    //Pickerview outlet
    var pickerData: [String] = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        //UI VALUES
         self.uiValueData()
    }

    func uiValueData(){
        //call api for product list
        self.callProductApi()
        lblNoData.isHidden = true
        
        // Connect data for pickerview
        self.picker.delegate = self
        self.picker.dataSource = self
        
        // Input the data into the array
        pickerData = [constant.PICKERFILTERHIGH, constant.PICKERFILTERLOW]
        
        //register cell for collection view
        self.RegisterCell()
    }
    
    func RegisterCell(){
        collectionProductList.register(UINib(nibName: constant.PRODUCTLISTNIB, bundle: nil), forCellWithReuseIdentifier: constant.PRODUCTLISTNIB)
    }
    //Api calling for product List
    func callProductApi() {
        if CommonFunction.sharedInstance.isConnectedToNetwork(){
            self.showActivityIndicator()
            userService.GetProductListData(callback: callbackMapDetails)
        }else{
            self.showNormalAlert(title: kProjectName, msg: Message.kNoInterNet.rawValue)
        }
    }
    func callbackMapDetails(flag : Bool, response: RequestOutcome?, msg: String?,isinternet : Bool ) {
         self.hideActivityIndicator()
        
        if flag{
            if response?.products?.count != 0{
                arrProductList = response?.products ?? [ProductResModel]()
                arrAllProductList = arrProductList
                arrAssuredPrductsList = arrProductList.filter { $0.details?.assured == 1 }
                lblTitle.text = response?.pageTitle ?? ""
                collectionProductList.delegate = self
                collectionProductList.dataSource = self
                collectionProductList.reloadData()
            }else{
                lblNoData.isHidden = false
            }
        }else{
            lblNoData.isHidden = false
            lblNoData.text = msg ?? Message.kNoInterNet.rawValue
            self.view.makeToast(message: msg ?? Message.kNoInterNet.rawValue, duration: 1.0, position: HRToastPositionCenter as AnyObject)
        }
    }
    
    //Set count for different collection view items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrProductList.count
    }
    
    //Set Data values for different collection view items
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard  let cell = collectionProductList.dequeueReusableCell(withReuseIdentifier: constant.PRODUCTLISTNIB, for: indexPath as IndexPath) as? ProductListCVCell else{
            return ProductListCVCell()
        }
        
        //Set Data
        let productData = arrProductList[indexPath.row].details ?? ProductDetailsResModel()
        cell.lblProductName.text = productData.title ?? ""
        cell.lblCurrentPrice.text = "₹\(productData.variants?[0].priceDetails?.listedPrice ?? 0)"
        cell.lblOldPrice.text = "\(productData.variants?[0].priceDetails?.labelPrice ?? 0)"
        cell.lblPercentageOff.text = "\(productData.variants?[0].priceDetails?.percentOff ?? 0)% off"
        cell.ratingView.rating = Float(arrProductList[indexPath.row].productRating ?? 0)
        
        
        DispatchQueue.global().async {
            let str = "\(self.arrProductList[indexPath.row].images?.thumbImages?[0] ?? "")"
            DispatchQueue.main.async {
                cell.imgProduct.sd_setImage(with: URL(string: str), placeholderImage: self.constant.IMGNOIMAGE)
            }
        }
        cell.btnWishlist.addTarget(self, action: #selector(self.btnWishlistTap(_sender:)), for: .touchUpInside)
        cell.btnWishlist.tag = indexPath.row
        
        return cell
    }
    
    //Drag user to the Product DetailView com=ntroller
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productDetailVC = UIStoryboard.productDetailController()
        productDetailVC?.arrSimiliarProduct = arrProductList
        productDetailVC?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(productDetailVC!, animated: true, completion: nil)
    }
    
    //Set collection view Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var itemWidth = CGFloat()
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            itemWidth = (collectionProductList.bounds.width / 2)-1
            break
        case .pad:
            itemWidth = (collectionProductList.bounds.width / 3)
            break
        default:
            break
        }
        return CGSize(width: itemWidth, height: CGFloat(255))
    }
    
    //Add product to the wishlist
    @objc func btnWishlistTap(_sender:UIButton){
        _sender.isSelected = !_sender.isSelected
        if _sender.isSelected{
            self.view.makeToast(message: "product \(arrProductList[_sender.tag].details?.title ?? "") added in your wishlist", duration: 2.0, position: HRToastPositionCenter as AnyObject)
        }else{
            self.view.makeToast(message: "product \(arrProductList[_sender.tag].details?.title ?? "") deleted from your wishlist", duration: 2.0, position: HRToastPositionCenter as AnyObject)
        }
    }
    
    //Assured product list action
    @IBAction func btnAssuredListTap(_sender:UISwitch){
        if _sender.isOn{
            arrProductList = arrAssuredPrductsList
        }else{
            arrProductList = arrAllProductList
        }
        if arrProductList.count == 0{
            self.lblNoData.isHidden = false
        }else{
            self.lblNoData.isHidden = true
        }
        collectionProductList.delegate = self
        collectionProductList.dataSource = self
        collectionProductList.reloadData()
    }
    
    //Filter/Sort for list
    @IBAction func filterSortNearbyTap(_sender:UIButton){
        picker.isHidden = false
        if _sender.tag == 0{
        }else if _sender.tag == 1{
        }else{
        }
    }
    
    // Number of columns of data
     func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        picker.isHidden = true
        return pickerData[row]
    }
}

