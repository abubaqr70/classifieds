//
//  MyCustomUIImageView.swift
//  Classifieds
//
//  Created by Muhammad Abubaqr on 2/19/21.
//

import Foundation
import UIKit

@IBDesignable class MyCustomImageView:UIImageView {
    

    @IBInspectable var CustomborderColor:UIColor = UIColor.white {
        willSet {
            layer.borderColor = newValue.cgColor
        }
    }
    @IBInspectable var  ImageborderWidth: CGFloat = 2.0 {
        didSet {
            self.layer.borderWidth = ImageborderWidth
        }
    }

    @IBInspectable var CustomCornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = CustomCornerRadius
            layer.masksToBounds = true
            layer.borderWidth = 1
            layer.borderColor = CustomborderColor.cgColor

        }
    }
   
    @IBInspectable var roundImage: Bool = false {
        didSet {
            layer.cornerRadius = frame.height/2
            layer.masksToBounds = true
            layer.borderWidth = 1
            layer.borderColor = CustomborderColor.cgColor
        }
    }

}
