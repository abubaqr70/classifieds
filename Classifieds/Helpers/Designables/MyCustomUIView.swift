//
//  MyCustomUIView.swift
//  Classifieds
//
//  Created by Muhammad Abubaqr on 2/19/21.
//

import Foundation
import UIKit

@IBDesignable class MyCustomUIView: UIView {
    
    @IBInspectable var CustomBorderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = CustomBorderColor.cgColor
        }
    }
    
    @IBInspectable var CustomBorderWidth: CGFloat = 2.0 {
        didSet {
            self.layer.borderWidth = CustomBorderWidth
        }
    }
    
    @IBInspectable var CustomCornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = CustomCornerRadius
        }
    }
    @IBInspectable var roundView: Bool = false {
        didSet {
            layer.cornerRadius = frame.height/2
            layer.masksToBounds = true
            layer.borderWidth = 1
            layer.borderColor = CustomBorderColor.cgColor
        }
    }
    
    
    @IBInspectable var viewShadow: Bool = false {
        didSet {
            addShadow()
        }
    }

    private func setupShadow() {
//        layer.cornerRadius = 8
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.3
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 8, height: 8)).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }

}

