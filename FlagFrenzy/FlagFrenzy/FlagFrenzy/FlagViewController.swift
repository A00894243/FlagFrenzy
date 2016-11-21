//
//  FlagViewController.swift
//  FlagFrenzy
//
//  Created by Student on 2016-11-20.
//  Copyright © 2016 Spencer Joel. All rights reserved.
//

import UIKit

class FlagViewController: UIViewController {

    let myImageView : UIImageView = UIImageView()
    
    let flagDone:UIButton! = UIButton(type:.custom)
    override func viewDidLoad() {
        super.viewDidLoad()

        let normal = UIControlState(rawValue: 0) //.normal doesn't exist in beta. workaround
        flagDone.setTitle("Done", for: normal)
        flagDone.setTitleColor(UIColor.white, for: normal)
        flagDone.backgroundColor = UIColor.blue
        flagDone.titleLabel!.font = UIFont(
            name: "Helvetica",
            size: 24)
        flagDone.titleLabel?.textAlignment = .left
        flagDone.frame = CGRect(
            x:10,
            y:400,
            width:400,
            height:50)
        flagDone.addTarget(self,action: #selector(self.flagDone(_:)),for: .touchUpInside)
        view.addSubview(flagDone)
        
        myImageView.frame = view.frame
        myImageView.frame = CGRect(
            x: 10,
            y: 200,
            width: 320,
            height: 160)
        view.addSubview(myImageView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func flagDone(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
