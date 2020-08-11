//
//  Extensions.swift
//  LocumDay
//
//  Created by Bhuvan Sharma on 12/1/15.
//  Copyright © 2015 Bhuvan Sharma. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper


//MARK: Getting screen size for check conditions
extension UIScreen {
    
    enum SizeType: CGFloat {
        case Unknown = 0.0
        case iPhone4 = 480.0
        case iPhone5 = 568.0
        case iPhone6 = 667.0
        case iPhone6Plus = 736.0
    }
    
    var sizeType: SizeType {
        let height = UIScreen.main.bounds.size.height
        guard let sizeType = SizeType(rawValue: height) else { return .Unknown }
        return sizeType
    }
}

//MARK: UIView extention for animation fade in and fade out

extension UIView {
    func fadeIn(duration: TimeInterval = 0.2, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
            self.isHidden = false
            }, completion: completion)  }
    
    func fadeOut(duration: TimeInterval = 0.2, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
            self.isHidden = true
            }, completion: completion)
    }
    
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(animation, forKey: nil)
    }

}


//MARK: Custom Color
extension UIColor
{
    var customBorderColor: UIColor {
        return UIColor(red: 213.0/255, green: 214.0/255, blue: 207.0/255, alpha: 1.0)
    }
    
    var worngAlertColor: UIColor {
        return UIColor(red: 203.0/255, green: 50.0/255, blue: 58.0/255, alpha: 1.0)
    }
    
    var appGreenColor: UIColor {
        
        return UIColor(red: 99.0/255, green: 177.0/255, blue: 46.0/255, alpha: 1.0)
    }
    
    var appYellowColor: UIColor {
        
        return UIColor(red: 255.0/255, green: 126.0/255, blue: 0.0/255, alpha: 1.0)
    }
    
    convenience init(hex: String) {
        self.init(hex: hex, alpha:1)
    }
    
    convenience init(hex: String, alpha: CGFloat) {
        var hexWithoutSymbol = hex
        if hexWithoutSymbol.hasPrefix("#") {
            hexWithoutSymbol = hex.substring(from: 1)
        }
        
        let scanner = Scanner(string: hexWithoutSymbol)
        var hexInt:UInt32 = 0x0
        scanner.scanHexInt32(&hexInt)
        
        var r:UInt32!, g:UInt32!, b:UInt32!
        switch (hexWithoutSymbol.length) {
        case 3: // #RGB
            r = ((hexInt >> 4) & 0xf0 | (hexInt >> 8) & 0x0f)
            g = ((hexInt >> 0) & 0xf0 | (hexInt >> 4) & 0x0f)
            b = ((hexInt << 4) & 0xf0 | hexInt & 0x0f)
            break;
        case 6: // #RRGGBB
            r = (hexInt >> 16) & 0xff
            g = (hexInt >> 8) & 0xff
            b = hexInt & 0xff
            break;
        default:
            // TODO:ERROR
            break;
        }
        
        self.init(
            red: (CGFloat(r)/255),
            green: (CGFloat(g)/255),
            blue: (CGFloat(b)/255),
            alpha:alpha)
    }

    
}

//MARK: StringHeight
extension String {
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.height
    }
    
    static func className(aClass: AnyClass) -> String {
        
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    
    func substring(from: Int) -> String {
        return self.substring(from: self.startIndex)
       
    }
    
    var length: Int {
        return self.count
    }
    var validPhoneNumber:Bool {
        let types:NSTextCheckingResult.CheckingType = [.phoneNumber]
        guard let detector = try? NSDataDetector(types: types.rawValue) else { return false }
        
        if let match = detector.matches(in: self, options: [], range: NSMakeRange(0, characters.count)).first?.phoneNumber {
            return match == self
        }else{
            return false
        }
    }
    
    func isStringAnInt() -> Bool {
        
        if let _ = Int(self) {
            return true
        }
        return false
    }
    var floatValue: Float {
            return (self as NSString).floatValue
    }
}


public extension UITableView {
    
    func registerCellClass(cellClass: AnyClass) {
        let identifier = String.className(aClass: cellClass)
        self.register(cellClass, forCellReuseIdentifier: identifier)
    }
    
    func registerCellNib(cellClass: AnyClass) {
        let identifier = String.className(aClass: cellClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellReuseIdentifier: identifier)
    }
    
    func registerHeaderFooterViewClass(viewClass: AnyClass) {
        let identifier = String.className(aClass: viewClass)
        self.register(viewClass, forHeaderFooterViewReuseIdentifier: identifier)
    }
    
    func registerHeaderFooterViewNib(viewClass: AnyClass) {
        let identifier = String.className(aClass: viewClass)
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forHeaderFooterViewReuseIdentifier: identifier)
    }
}



//MARK: Make StoryBoard Object
extension UIStoryboard
{
    class func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: Bundle.main) }

    //***********************************************//
                    //MARK: Main Storyboard Classes
    //***********************************************//
    class func productDetailController() -> ProductDetailsVC? {
        return mainStoryboard().instantiateViewController(withIdentifier: "ProductDetailsVC") as? ProductDetailsVC
    }
}

public extension Int {
    /// Returns a random Int point number between 0 and Int.max.
    public static func random(lower: Int = 0, _ upper: Int = 100) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
}

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: [Iterator.Element: Bool] = [:]
        return self.filter { seen.updateValue(true, forKey: $0) == nil }
    }
}

extension Date {
    
    func years(sinceDate: Date) -> Int? {
        return Calendar.current.dateComponents([.year], from: sinceDate, to: self).year
    }
    
    func months(sinceDate: Date) -> Int? {
        return Calendar.current.dateComponents([.month], from: sinceDate, to: self).month
    }
    
    func days(sinceDate: Date) -> Int? {
        return Calendar.current.dateComponents([.day], from: sinceDate, to: self).day
    }
    
    func hours(sinceDate: Date) -> Int? {
        return Calendar.current.dateComponents([.hour], from: sinceDate, to: self).hour
    }
    
    func minutes(sinceDate: Date) -> Int? {
        return Calendar.current.dateComponents([.minute], from: sinceDate, to: self).minute
    }
    
    func seconds(sinceDate: Date) -> Int? {
        return Calendar.current.dateComponents([.second], from: sinceDate, to: self).second
    }
    
    static func -(recent: Date, previous: Date) -> (month: Int?, day: Int?, hour: Int?, minute: Int?, second: Int?) {
        let day = Calendar.current.dateComponents([.day], from: previous, to: recent).day
        let month = Calendar.current.dateComponents([.month], from: previous, to: recent).month
        let hour = Calendar.current.dateComponents([.hour], from: previous, to: recent).hour
        let minute = Calendar.current.dateComponents([.minute], from: previous, to: recent).minute
        let second = Calendar.current.dateComponents([.second], from: previous, to: recent).second
        
        return (month: month, day: day, hour: hour, minute: minute, second: second)
    }
    
}

