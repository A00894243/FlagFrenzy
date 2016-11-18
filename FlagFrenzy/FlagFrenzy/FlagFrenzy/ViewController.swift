//
//  ViewController.swift
//  FlagFrenzy
//
//  Created by Spencer Joel on 2016-11-18.
//  Copyright © 2016 Spencer Joel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    var pickerData : [String] = []
    //http://www.geognos.com/api/en/countries/info/all.json
    //http://www.geognos.com/api/en/countries/flag/BE.png
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.dataSource = self
        myTableView.delegate = self
        pickerData = loadValues()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadValues() -> [String]{
        var holder = [String]()
        Alamofire.request("https://restcountries.eu/rest/v1/all").responseJSON {
            (response) -> Void in
            if((response.result.value) != nil){
                //debugPrint(response)
                let json = JSON(response.result.value!)
                for (_,subJson):(String, JSON) in json {
                    let temp = subJson["name"].stringValue
                    holder.append(temp)
                }
                print(holder)
                self.pickerData = holder
                self.myTableView.reloadData()
            }
        }
        
        return holder
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Getting the right element
        let element = pickerData[indexPath.row]
        
        // Instantiate a cell
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "ElementCell")
        
        // Adding the right informations
        cell.textLabel?.text = element
        //cell.detailTextLabel?.text = element
        
        // Returning the cell
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pickerData.count
    }


}

