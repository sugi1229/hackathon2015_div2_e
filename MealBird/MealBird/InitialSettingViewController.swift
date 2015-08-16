//
//  InitialSettingViewController.swift
//  MealBird
//
//  Created by admin on 2015/08/16.
//  Copyright (c) 2015年 div2_e. All rights reserved.
//

import UIKit

class InitialSettingViewController: UIViewController {
    
    @IBOutlet var asaTime: UILabel!
    @IBOutlet var hiruTime: UILabel!
    @IBOutlet var yoruTime: UILabel!
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet weak var asaView: UIButton!
    @IBOutlet weak var hiruView: UIButton!
    @IBOutlet weak var yoruView: UIButton!
    
    
    private let asaValue: NSArray = ["4:00 ~ 6:00","4:30 ~ 6:30","5:00 ~ 7:00","5:30 ~ 7:30","6:00 ~ 8:00","6:30 ~ 8:30","7:00 ~ 9:00","7:30 ~ 9:30","8:00 ~ 10:00"]
    private let hiruValue: NSArray = ["10:00 ~ 12:00","10:30 ~ 12:30","11:00 ~ 13:00","11:30 ~ 13:30","12:00 ~ 14:00","12:30 ~ 14:30","13:00 ~ 15:00","13:30 ~ 15:30","14:00 ~ 16:00"]
    private let yoruValue: NSArray = ["16:00 ~ 18:00","16:30 ~ 18:30","17:00 ~ 19:00","17:30 ~ 19:30","18:00 ~ 20:00","18:30 ~ 20:30","19:00 ~ 21:00","19:30 ~ 21:30", "20:00 ~ 22:00"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onClickView(sender : UIView){
        
    }
    
    //asaview touch
    @IBAction func didTapAsaView(sender: AnyObject) {
        
    }
    
    //hirugohan touch
    @IBAction func didTapHiruView(sender: AnyObject) {
    }
    
    //yorugohan touch
    @IBAction func didTapYouView(sender: AnyObject) {
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
