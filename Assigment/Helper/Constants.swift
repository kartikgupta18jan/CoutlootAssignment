//
//  Constants.swift
//  Artsic
//
//  Created by Nitesh Vishwakarma on 19/05/20.
//  Copyright © 2020 Nitesh Vishwakarma. All rights reserved.
//

import Foundation
import UIKit

class Constant {
    
    static let middleDot = "·"
    
    static let networkErrorMsg = "Please connect to internet"
    static let unknownError = "Something went wrong"
    static let dataBindingError = "Unable to format data"
    
    static let PICKERFILTERHIGH = "High to Low"
    static let PICKERFILTERLOW = "Low to High"
    
    //Color
    let lightOrange = UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 0.5)
    let darkOrange = UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 0.5)
    let REDCOLOR = UIColor(hex: "E3414F")
    let LIGHTGRAYCOLOR = UIColor(hex: "76848B")
    let BACKGROUNDPINKCOLOR = UIColor(hex: "FFEAEC")
    let WHITECOLOR = UIColor.white
    let GRAYCOLOR = UIColor.gray
    
    //ImagesConstant
    let IMGNOIMAGE = UIImage(named: "noImage")
    let IMGDELIVERY = UIImage(named: "noun_delivery_191970")
    let IMGMONEY = UIImage(named: "noun_Money_2277832")
    let IMGRETURN = UIImage(named: "noun_return_3087982")
    let IMGDiscount = UIImage(named: "noun_Discount_2847595")
    let REVIEWIMAGEGRAY = UIImage(named: "gray-star-icon")
    let REVIEWIMAGEYELLOW = UIImage(named: "ful-star-icon")
    
    //Labledata
    let PICKERFILTERHIGH = "High to Low"
    let PICKERFILTERLOW = "Low to High"
    let SIZESMALL = "Small"
    let SIZEMEDIUM = "Medium"
    let SIZELARGE = "Large"
    let HEADERDELIVERY = "Delivery Details"
    let HEADEROFFER = "Available Offers"
    let DATEFORMATE = "yyyy-MM-dd HH:mm:ss"
    
    //CELL NIB CONSTANT
    let PRODUCTLISTNIB = "ProductListCVCell"
    let SIMILIARPRODUCTNIB = "SimiliarProductListCVCell"
    let DELIVERYPRODUCTNIB = "DeliveryTVCell"
    let HEADERPRODUCTNIB = "ProductDetailHeaderV"
    let MORECOLORNIB = "MoreColorCVCell"
    let SIZEPRODUCTNIB = "ProductSizeCVCell"
}
