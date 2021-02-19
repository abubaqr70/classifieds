//
//  UIViewController+Additions.swift
//  Classifieds
//
//  Created by Muhammad Abubaqr on 2/19/21.
//

import UIKit

extension UIViewController{
    func clearNavigation(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
    }
    
    func dissmissBackButton(imageName:String = "ic_back",color:String = "#FA6367"){
        let image = UIImage(named:imageName)!.withRenderingMode(.alwaysOriginal)
        let btnCancel = UIBarButtonItem(image: image.imageFlippedForRightToLeftLayoutDirection(), style: .plain, target: self, action: #selector(backButtonAction))
        btnCancel.tintColor = UIColor.hexStringToUIColor(hex: color)
        self.navigationItem.leftBarButtonItem  = btnCancel
        
    }
   
    @objc private func backButtonAction(){
        self.navigationController?.popViewController(animated: true)
    }

}

