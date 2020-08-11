//
//  ButtonRoundCorner.swift
//  ASSIGNMENT
//

import UIKit


class ButtonRoundCorner: UIButton {
    
    override func awakeFromNib() {
        self.layer.cornerRadius = self.layer.frame.size.height/2;
        self.layer.masksToBounds = true
    }

}
