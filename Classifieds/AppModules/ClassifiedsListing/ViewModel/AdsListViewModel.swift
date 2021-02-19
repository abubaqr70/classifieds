//
//  AdsListViewModel.swift
//  Classifieds
//
//  Created by Muhammad Abubaqr on 2/19/21.
//

import Foundation
import UIKit
import SwiftyJSON

protocol AdsListViewControllerDelagte {
    func didFetchData()
}
class AdsListViewModel: NSObject {
    
    var delegate:AdsListViewControllerDelagte?
    var ads:[Ads] = [Ads]()
    private var arrSearch:[Ads] = [Ads]()
    private weak var context: UIViewController?
    public init(context: UIViewController) {
        super.init()
        self.context = context
        //viewDidLoad()
    }
    func viewDidLoad(){
        //        let newJson = Functions.getJSON("Ads")
        //        if newJson != nil{
        //            self.initializeAdsModel(result: newJson!)
        //        }
        let adsArray = CoreDataManager.fetchAdsList()
        if adsArray != nil {
            self.initializeAds(ads: adsArray!)
        }
        getAdsList()
    }
    
    func getAdsList(){
        ApiManager.getRequest(with: APPURL.classifieds, parameters: nil, completion: { (result) in
            switch result {
            case .success(let result):
                print(result)
                self.ads.removeAll()
                CoreDataManager.resetAllRecords(in: "AdsModel")
                for rec in result["results"].arrayValue {
                    CoreDataManager.saveAdsInDb(with: rec)
                }
                let adsArray = CoreDataManager.fetchAdsList()
                if adsArray != nil {
                    self.initializeAds(ads: adsArray!)
                }
            //                Functions.saveJSON(json: result, key: "Ads")
            //                let newJson = Functions.getJSON("Ads")
            //                self.initializeAdsModel(result: newJson!)
            case .failure(let error):
                print(error)
                
            }
        })
    }
    func initializeAds(ads:[Ads]){
        self.ads.removeAll()
        self.arrSearch.removeAll()
        self.ads = ads
        self.arrSearch = ads
        self.delegate?.didFetchData()
    }
    
    func initializeAdsModel(result:JSON){
        self.ads.removeAll()
        for rec in result["results"].arrayValue {
            self.ads.append(Ads(fromJson: rec))
        }
        self.delegate?.didFetchData()
    }
    
    func createSearchBar(viewSearch:UIView) {
        viewSearch.autoresizesSubviews = true
        let customSearchBar = CustomSearchBar(frame: viewSearch.frame)
        customSearchBar.frame = viewSearch.bounds
        customSearchBar.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        customSearchBar.delegate = self
        viewSearch.addSubview(customSearchBar)
    }
    
}
extension AdsListViewModel:CustomSearchBarDelegate{
    
    func textDidChange(searchText: String) {
        if searchText.isEmpty == true {
            ads = arrSearch
        }else{
            ads = arrSearch
            ads = (ads.filter {(($0.name)?.range(of: searchText, options: [.diacriticInsensitive, .caseInsensitive]) != nil) })
        }
        self.delegate?.didFetchData()
    }
}
