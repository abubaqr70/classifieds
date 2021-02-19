//
//  AdsListViewController.swift
//  Classifieds
//
//  Created by Muhammad Abubaqr on 2/19/21.
//

import UIKit

class AdsListViewController: UIViewController {

    @IBOutlet weak var searchBar: UIView!
    @IBOutlet weak var tblAdsList: UITableView!
    var objVM : AdsListViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        objVM = AdsListViewModel(context: self)
        objVM?.delegate = self
        objVM?.viewDidLoad()
        clearNavigation()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "appColor") as Any]
        objVM?.createSearchBar(viewSearch: searchBar)
        self.tblAdsList.register(UINib(nibName: "AdsListingTableViewCell", bundle: nil), forCellReuseIdentifier: "AdsListingTableViewCell")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "adsDetail"{
            if let controller = segue.destination as? AdsDetailViewController{
                let obj =  sender as! Ads
                controller.objAd = obj
            }
        }
    }
    
}
extension AdsListViewController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objVM?.ads.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblAdsList.dequeueReusableCell(withIdentifier: "AdsListingTableViewCell") as! AdsListingTableViewCell
        cell.selectionStyle = .none
        if objVM?.ads.count ?? 0 > 0 {
            cell.objAd = objVM?.ads[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "adsDetail", sender: objVM?.ads[indexPath.row])
    }
    
}
extension AdsListViewController: AdsListViewControllerDelagte{
    func didFetchData() {
        self.tblAdsList.reloadData()
    }
}
