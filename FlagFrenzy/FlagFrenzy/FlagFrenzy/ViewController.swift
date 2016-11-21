//
//  ViewController.swift
//  FlagFrenzy
//
//  Created by Spencer Joel on 2016-11-18.
//  Copyright © 2016 Spencer Joel. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var myPicker: UIPickerView!
    @IBOutlet weak var countryNameButton: UIButton!
    
    var flagImage : UIImage = UIImage()
    var data : [String: String] = [:]
    var id : [String] = []
    var values : [String] = []
    //http://www.geognos.com/api/en/countries/info/all.json
    //http://www.geognos.com/api/en/countries/flag/BE.png
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myPicker.dataSource = self
        myPicker.delegate = self
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
                    let tempVal = subJson["Name"].stringValue
                    let tempKey = key
                    print(key)
                    self.id.append(tempKey)
                    self.values.append(tempVal)
                    self.data[tempVal] = tempKey
                }
                //print(holder)
                //self.data = holder
                print(self.id)
                print(self.values)
                //self.id.sort()
                self.values.sort()
                //self.myTableView.reloadData()
                self.myPicker.reloadAllComponents()
            }
        }
        
        //return holder
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return values.count
    }
    //MARK: Delegates
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return values[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //myImageView.image = pickerValues[row]
        //selectedRow = row
        self.countryNameLabel.text = values[row]
        Alamofire.request("http://www.geognos.com/api/en/countries/flag/"+data[values[row]]!+".png").responseImage { response in
            debugPrint(response)
            
       //     print(response.request)
       //     print(response.response)
            debugPrint(response.result)
            
            if let image = response.result.value {
                print("image downloaded: \(image)")
                self.flagImage = image
            }
        }
        
    }
    @IBAction func openFlagModal(_ sender: UIButton) {
        let vc = FlagViewController()
        vc.modalTransitionStyle = .partialCurl
        vc.myImageView.image = self.flagImage
        vc.view.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        present(vc, animated: true, completion: nil)
    }
    


}

