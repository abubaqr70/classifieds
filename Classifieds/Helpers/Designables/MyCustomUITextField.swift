//
//  MyCustomUITextField.swift
//  Classifieds
//
//  Created by Muhammad Abubaqr on 2/19/21.
//

import Foundation
import UIKit

@IBDesignable open class MyCustomUITextField: UITextField {
        
    func addIcon(andImage img:UIImage)
    {
        let imageView = UIImageView(image: img)
        imageView.contentMode = .scaleAspectFit
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 50))
        imageView.frame = CGRect(x: 13.0, y: 13.0, width: 30, height: 30 )
        let seperatorView = UIView(frame: CGRect(x: 50, y: 0, width: 10, height: 50))
        view.addSubview(seperatorView)
        if !ImageIconOnRight {
            self.leftViewMode = .always
            view.addSubview(imageView)
            self.leftViewMode = UITextField.ViewMode.always
            self.leftView = view
        }
        else {
            self.rightViewMode = .always
            view.addSubview(imageView)
            self.rightViewMode = UITextField.ViewMode.always
            self.rightView = view
        }
    }
    
    @IBInspectable var ImageIconOnRight: Bool = false
    @IBInspectable var AddImageIcon: Bool = false {
        didSet {
            if AddImageIcon{
                addIcon(andImage: IconImage)
            }
        }
    }
    
    @IBInspectable var IconImage: UIImage = UIImage(){
        didSet{
            addIcon(andImage: IconImage)
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat  = 0 {
        
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0) {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
        
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.shadowColor!)
        }
        set {
            self.layer.shadowColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var shadowRadius: Double {
        get {
            return Double(self.layer.shadowRadius)
        }
        set {
            self.layer.shadowRadius = CGFloat(newValue)
        }
    }
    
    @IBInspectable var paddingLeftCustom: CGFloat {
        get {
            return leftView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            leftView = paddingView
            leftViewMode = .always
        }
    }
    
    @IBInspectable var paddingRightCustom: CGFloat {
        get {
            return rightView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            rightView = paddingView
            rightViewMode = .always
        }
    }
}
