//
//  AdsListingTableViewCell.swift
//  Classifieds
//
//  Created by Muhammad Abubaqr on 2/19/21.
//

import UIKit
import Foundation
import SDWebImage


class AdsListingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var adPostedDate: UILabel!
    @IBOutlet weak var adPrice: UILabel!
    @IBOutlet weak var adImage: UIImageView!
    @IBOutlet weak var adName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var objAd : Ads? {
        didSet{
            self.adName.text = objAd?.name
            self.adPrice.text = objAd?.price
            let newdate = Functions.GetDateStringReturnDate(dateString: objAd?.createdAt ?? "", formate: "h:mm a, MMM d,yyyy") as Date
            self.adPostedDate.text = " \((NSDate.relativePast(for: newdate)))"
            if objAd?.imageUrls?.count ?? 0 > 0 {
                adImage.sd_setImage(with: URL(string: objAd?.imageUrls![0] ?? ""))
            }
            
        }
    }
    
}
