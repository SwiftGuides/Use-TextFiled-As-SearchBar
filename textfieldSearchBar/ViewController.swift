//
//  ViewController.swift
//  textfieldSearchBar
//
//  Created by MacMini on 2/27/19.
//  Copyright © 2019 Immanent. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
   
    @IBOutlet weak var txtSearchBar: UITextField!
    @IBOutlet var tblView: UITableView!
    
    //Variables
    var searchActive : Bool = false
    
    var data = ["San Francisco","New York","San Jose","Chicago","Los Angeles","Austin","Seattle"]
    
    var filtered:[String] = []



    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        txtSearchBar.delegate = self
        txtSearchBar.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)),
                               for: UIControl.Event.editingChanged)

    }

    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        // filter tableViewData with textField.text
        
        let searchText  = textField.text
        
        filtered = data.filter({ (text) -> Bool in
            let tmp: NSString = text as NSString
            let range = tmp.range(of: searchText!, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tblView.reloadData()
        
    }

    
    
   /* func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        isFiltered = true
        searchResults = prods.filter({(coisas:String) -> Bool in
            let stringMatch = coisas.range(of: textField.text!)     //rangeOfString(textField.text)
            return stringMatch != nil
            
        })
        print(searchResults.description)
        textField.resignFirstResponder()
        tblView.reloadData()
        return true
    } */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive){
            return filtered.count
        } else {
            return data.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchTableViewCell", for: indexPath) as! searchTableViewCell
        
        if(searchActive){
            cell.textlabelSearch.text = filtered[indexPath.row]
        } else {
            cell.textlabelSearch.text = data[indexPath.row];
        }
        return cell
    }
    
}

