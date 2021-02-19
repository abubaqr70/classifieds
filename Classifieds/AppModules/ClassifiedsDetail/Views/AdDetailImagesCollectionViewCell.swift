//
//  AdDetailImagesCollectionViewCell.swift
//  Classifieds
//
//  Created by Muhammad Abubaqr on 2/19/21.
//

import UIKit

class AdDetailImagesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var adImages: MyCustomImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var image : String? {
        didSet{
            adImages.sd_setImage(with: URL(string: image ?? ""))
            let tap = UITapGestureRecognizer(target: self, action: #selector(imageTappedAction(_:)))
            adImages.addGestureRecognizer(tap)
            adImages.isUserInteractionEnabled = true
        }
        
    }
    
    @objc func imageTappedAction(_ sender: UITapGestureRecognizer) {
        UIApplication.shared.keyWindow?.endEditing(true)
        
        if self.adImages.image != nil{
            let image =  FullScreenImage(image: self.adImages.image!)
            UIApplication.shared.keyWindow?.addSubview(image)
        }
    }
}
