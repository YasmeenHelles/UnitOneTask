//
//  ViewUI.swift
//  Offerta
//
//  Created by Shaima Farahat on 3/18/19.
//  Copyright © 2019 Shaima Farahat. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class RoundedUIView: UIView {
    
    override func layoutSubviews() { setup() }
    private var radius: CGFloat = 0;
    
    @IBInspectable var topLeft: Bool = false{
        didSet{
            if topLeft {
                self.layer.maskedCorners.insert(CACornerMask.layerMinXMinYCorner)
            }else{
                self.layer.maskedCorners.remove(CACornerMask.layerMinXMinYCorner)
            }
        }
    }
    
    @IBInspectable var bottomLeft: Bool = false{
        didSet{
            if bottomLeft {
                self.layer.maskedCorners.insert(CACornerMask.layerMinXMaxYCorner)
            }else{
                self.layer.maskedCorners.remove(CACornerMask.layerMinXMaxYCorner)
            }
        }
    }
    
    @IBInspectable var topRight: Bool = false{
        didSet{
            if topRight {
                self.layer.maskedCorners.insert(CACornerMask.layerMaxXMinYCorner)
            }else{
                self.layer.maskedCorners.remove(CACornerMask.layerMaxXMinYCorner)
            }
        }
    }
    
    @IBInspectable var bottomRight: Bool = false{
        didSet{
            if bottomRight {
                self.layer.maskedCorners.insert(CACornerMask.layerMaxXMaxYCorner)
            }else{
                self.layer.maskedCorners.remove(CACornerMask.layerMaxXMaxYCorner)
            }
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
    
    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var bgColor: UIColor = UIColor.clear{
        didSet{
            self.backgroundColor = bgColor
        }
    }
    
    func setup() {
        self.clipsToBounds = true
    }
}
