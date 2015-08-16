//
//  InitialSettingViewController.swift
//  MealBird
//
//  Created by admin on 2015/08/16.
//  Copyright (c) 2015年 div2_e. All rights reserved.
//

import UIKit

class InitialSettingViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource{
    
    @IBOutlet var asaTime: UILabel!
    @IBOutlet var hiruTime: UILabel!
    @IBOutlet var yoruTime: UILabel!
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet weak var asaView: UIButton!
    @IBOutlet weak var hiruView: UIButton!
    @IBOutlet weak var yoruView: UIButton!
    
    //どれが選択されているかを判断する
    private var flagSelect: Int! = 0
    
    //選択された値を保存しておく用
    private var asaSelect: Int! = 0
    private var hiruSelect: Int! = 0
    private var yoruSelect: Int! = 0
    
    //UserDefault用
    private let ud = NSUserDefaults.standardUserDefaults()
    
    //pickerに表示する用の配列
    private let asaValue: [String] = ["4:00 ~ 6:00","4:30 ~ 6:30","5:00 ~ 7:00","5:30 ~ 7:30","6:00 ~ 8:00","6:30 ~ 8:30","7:00 ~ 9:00","7:30 ~ 9:30","8:00 ~ 10:00"]
    private let hiruValue: [String] = ["10:00 ~ 12:00","10:30 ~ 12:30","11:00 ~ 13:00","11:30 ~ 13:30","12:00 ~ 14:00","12:30 ~ 14:30","13:00 ~ 15:00","13:30 ~ 15:30","14:00 ~ 16:00"]
    private let yoruValue: [String] = ["16:00 ~ 18:00","16:30 ~ 18:30","17:00 ~ 19:00","17:30 ~ 19:30","18:00 ~ 20:00","18:30 ~ 20:30","19:00 ~ 21:00","19:30 ~ 21:30", "20:00 ~ 22:00"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //初期状態で"朝"を選択している状態
        asaView.backgroundColor = UIColor.grayColor()
        
        pickerView.delegate = self
        pickerView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //表示列
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1    //1行
    }
    
    //表示個数
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return asaValue.count
    }
    
    //表示内容
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String {
        switch(flagSelect){
        case 0:
            return asaValue[row]
        case 1:
            return hiruValue[row]
        case 2:
            return yoruValue[row]
        default:
            return ""
        }
    }
    
    //選択時
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch(flagSelect){
        case 0: //朝
            asaTime.text = asaValue[row]
            //UserDefaultに保存
            ud.removeObjectForKey("asa")
            ud.setObject(asaValue[row], forKey: "asa")
            //次に表示するとき用に保存
            asaSelect = row
            break
        case 1: //昼
            hiruTime.text = hiruValue[row]
            ud.removeObjectForKey("hiru")
            ud.setObject(hiruValue[row], forKey: "hiru")
            hiruSelect = row
            break
        case 2: //夜
            yoruTime.text = yoruValue[row]
            ud.removeObjectForKey("yoru")
            ud.setObject(yoruValue[row], forKey: "yoru")
            yoruSelect = row
            break
        default:
            break
        }
    }
    
    
    //朝の時間選択
    @IBAction func didTapAsaView(sender: AnyObject) {
        //Viewの色の選択
        asaView.backgroundColor = UIColor.grayColor()
        hiruView.backgroundColor = UIColor.whiteColor()
        yoruView.backgroundColor = UIColor.whiteColor()
        
        flagSelect = 0
        
        pickerView.reloadAllComponents()
        pickerView.selectRow(asaSelect, inComponent: 0, animated: true)
    }
    
    //昼の時間選択
    @IBAction func didTapHiruView(sender: AnyObject) {
        hiruView.backgroundColor = UIColor.grayColor()
        asaView.backgroundColor = UIColor.whiteColor()
        yoruView.backgroundColor = UIColor.whiteColor()
        
        flagSelect = 1
        
        pickerView.reloadAllComponents()
        pickerView.selectRow(hiruSelect, inComponent: 0, animated: true)

    }
    
    //夜の時間選択
    @IBAction func didTapYouView(sender: AnyObject) {
        yoruView.backgroundColor = UIColor.grayColor()
        asaView.backgroundColor = UIColor.whiteColor()
        hiruView.backgroundColor = UIColor.whiteColor()
        
        flagSelect = 2
        
        pickerView.reloadAllComponents()
        pickerView.selectRow(yoruSelect, inComponent: 0, animated: true)

    }
    
}
