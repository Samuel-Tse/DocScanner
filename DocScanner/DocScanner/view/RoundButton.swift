//
//  RoundButton.swift
//  DocScanner
//
//  Created by Samuel Tse on 26/4/19.
//  Copyright © 2019 Samuel Tse. All rights reserved.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    override func prepareForInterfaceBuilder() {
        sharedInit()
    }
    
    func sharedInit() {
        // Common logic goes here
    }
    
    @IBInspectable var isRound: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear{
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    func updateCornerRadius() {
        layer.cornerRadius = isRound ? frame.size.height / 2 : 0
    }
}
