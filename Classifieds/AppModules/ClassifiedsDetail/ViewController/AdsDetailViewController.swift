//
//  AdsDetailViewController.swift
//  Classifieds
//
//  Created by Muhammad Abubaqr on 2/19/21.
//

import UIKit

class AdsDetailViewController: UIViewController {
    
    @IBOutlet weak var adPostedDate: UILabel!
    @IBOutlet weak var adPrice: UILabel!
    @IBOutlet weak var adName: UILabel!
    @IBOutlet weak var cvAdImages: UICollectionView!
    var objAd : Ads?
    override func viewDidLoad() {
        super.viewDidLoad()
        clearNavigation()
        dissmissBackButton()
        let nib = UINib(nibName: "AdDetailImagesCollectionViewCell", bundle: nil)
        cvAdImages?.register(nib, forCellWithReuseIdentifier: "AdDetailImagesCollectionViewCell")
        cvAdImages.reloadData()
        setupValues()
        // Do any additional setup after loading the view.
    }
    
    func setupValues(){
        adName.text = objAd?.name
        adPrice.text = objAd?.price
        let newdate = Functions.GetDateStringReturnDate(dateString: objAd?.createdAt ?? "", formate: "h:mm a, MMM d,yyyy") as Date
        self.adPostedDate.text = " \((NSDate.relativePast(for: newdate)))"
    }
}
extension AdsDetailViewController:UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height
        let width  = collectionView.frame.width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objAd?.imageUrls?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  cvAdImages.dequeueReusableCell(withReuseIdentifier: "AdDetailImagesCollectionViewCell", for: indexPath) as! AdDetailImagesCollectionViewCell
        cell.image = objAd?.imageUrls?[indexPath.row]
        return cell
    }
    
}
