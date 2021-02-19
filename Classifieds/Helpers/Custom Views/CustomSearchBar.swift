//
//  CustomSearchBar.swift
//  Classifieds
//
//  Created by Muhammad Abubaqr on 2/19/21.
//

import Foundation
import UIKit

protocol CustomSearchBarDelegate {
    func textDidChange(searchText:String)
}

class CustomSearchBar: UIView , UITextFieldDelegate {
    
    var delegate:CustomSearchBarDelegate?
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var viewSearch: UIView!
    
    @IBOutlet weak var mytext: MyCustomUITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("CustomSearchBar", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        txtSearch.addTarget(self, action: #selector(textFieldDidChange(_:)), for:.editingChanged)
        viewSearch.addShadow(shadowColor: UIColor.hexStringToUIColor(hex: "#96A1A7").cgColor, shadowOpacity: 0.1, shadowRadius: 2.0)
        
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        let searchText  = textField.text!
        delegate?.textDidChange(searchText: searchText)
        if searchText.isEmpty == true {
            self.iconImg.image = UIImage(named: "ic_search")
        }
    }
    
    @IBAction func btnClearAction(_ sender:UIButton){
        self.txtSearch.text = ""
        self.iconImg.image = UIImage(named: "ic_search")
        delegate?.textDidChange(searchText: "")
        
    }
    //MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
