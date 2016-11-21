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
    var data : [String: String] = [:]
    var id : [String] = []
    var values : [String] = []
    //http://www.geognos.com/api/en/countries/info/all.json
    //http://www.geognos.com/api/en/countries/flag/BE.png
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.dataSource = self
        myTableView.delegate = self
        //data = loadValues()
        loadValues()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadValues() {
        //var holder = [String: String]()
        Alamofire.request("http://www.geognos.com/api/en/countries/info/all.json").responseJSON {
            (response) -> Void in
            if((response.result.value) != nil){
                //debugPrint(response)
                let json = JSON(response.result.value!)
                let results = json["Results"]
                debugPrint(json["Results"])
                debugPrint(results)
                for (key,subJson):(String, JSON) in results {
                    let temp = subJson["Name"].stringValue
                    let temp2 = key
                    print(key)
                    self.id.append(temp2)
                    self.values.append(temp)
                }
                //print(holder)
                //self.data = holder
                print(self.id)
                print(self.values)
                //self.id.sort()
                //self.values.sort()
                self.myTableView.reloadData()
            }
        }
        
        //return holder
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Getting the right element
        //let element = data[indexPath.row]
        
        // Instantiate a cell
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "ElementCell")
        
        // Adding the right informations
        cell.textLabel?.text = values[indexPath.row]
        cell.detailTextLabel?.text = id[indexPath.row]
        
        // Returning the cell
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return id.count
    }


}

