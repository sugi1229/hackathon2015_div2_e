//
//  birdHomeViewController.swift
//  MealBird
//
//  Created by minami on 8/16/15.
//  Copyright (c) 2015 div2_e. All rights reserved.
//

import UIKit
import AVFoundation
import SpriteKit

class birdHomeViewController: UIViewController {

    var cameraSession : AVCaptureSession!
    var myDevice : AVCaptureDevice!
    var imageOutput : AVCaptureStillImageOutput!
    var imagePreviewLayer : AVCaptureVideoPreviewLayer!
    
    var takePhotoButton : UIButton!
    var retakePhotoButton : UIButton!
    var decidePhotoButton : UIButton!
    var cameraMessageLabel : UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var photoPreviewImageView: UIImageView!
    var birdImageView : UIImageView!
    @IBOutlet weak var cameraButton: UIButton!
    var mealPhoto : UIImageView!
    
    private var myImageView: UIImageView!
    private var myImageViewArray: [UIImageView] = []
    private var myImage: UIImage!
    private var myValue: Int!
    
    private var nowTime: Int! = 0
    
    let userDefault = NSUserDefaults.standardUserDefaults()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupCammera()
        setupTakePhotoButtons()
        setupCameraMessageLabel()
        setupMessageLabel()
        setupAdultBirds()
        setupBird()
        setupMealPhoto()
        
        hiddenPhotoPreview()
        showCameraView()
       
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        showCameraView()
        hiddenHomeView()
        hiddenPhotoPreview()
        setupCameraMessageLabel()
        setupMessageLabel()
    }

    func setupMessageLabel() {
        if let count = userDefault.objectForKey("count") as? Int {
            switch count {
            case 0,1,2:
                messageLabel.text = "生まれるまで" + String(3 - count) + "食"
            case 3,4,5,6,7:
                messageLabel.text = "大人になるまであと" + String(8 - count) + "食"
            case 8,9:
                messageLabel.text = "卵が生まれるまで" + String(10 - count) + "食"
            default:
                break
            }
        }
    }
    
    func setupAdultBirds() {
        if let adultBirds = userDefault.objectForKey("adultBirds") as? [Int] {
            print("adultBirds")
            println(adultBirds)
        } else {
            let n = (Int)(arc4random() % 5)
            let adultBirds : [Int] = [n]
            userDefault.setObject(adultBirds, forKey: "adultBirds")
            myValue = 0;
        }
    }
    
    func setupBird() {
        birdImageView = UIImageView(frame: CGRectMake(0, 0, 50, 50))
        let tabbarHeight = self.tabBarController?.tabBar.frame.size.height;
        birdImageView.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height - tabbarHeight! - birdImageView.frame.size.height/2)
        birdImageView.contentMode = UIViewContentMode.ScaleAspectFill
    }
    
    func setupMealPhoto() {
        mealPhoto = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        mealPhoto.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2)
        mealPhoto.contentMode = UIViewContentMode.ScaleAspectFill
    }

    func getBirdImage(count: Int) -> UIImage {
      //setAdultBirdImage()
        switch count {
            case 0:
                //過去のとりの表示
                 //初回
                return UIImage(named: "tamago0.png")!
            case 1:
                return UIImage(named: "tamago1.png")!
            case 2:
                return UIImage(named: "tamago2.png")!
            case 3,4,5,6,7:
                return UIImage(named: "hiyoko.png")!
            case 8,9:
            if let adultBirds = userDefault.objectForKey("adultBirds") as? [Int] {
                switch adultBirds.last! {
                    case 0:
                        return UIImage(named: "botton_inko.png")!
                    case 1:
                        return UIImage(named: "kozakura_inko.png")!
                    case 2:
                        return UIImage(named: "okame_inko.png")!
                    case 3:
                        return UIImage(named: "sekisei_inko.png")!
                    case 4:
                        return UIImage(named: "sekisei2_inko.png")!
                    default:
                        return UIImage(named: "botton_inko.png")!
                    }
                } else {
                    return UIImage(named: "botton_inko.png")!
                }
            default:
                return UIImage(named: "hiyoko.png")!
        }
    }

    func didAddPhoto() {
        var count = 1
        if let prevCount = userDefault.objectForKey("count") as? Int {
            count = (prevCount + 1) % 10
        }
        userDefault.setObject(count, forKey: "count")
        
        //とり
        if count == 0 {
            setAdultBirdImage()
        }
        birdImageView.image = getBirdImage(count)
        setupMessageLabel()
        
        if count == 0 {
            setupAdultBird()
        }
    }
    
    func setupAdultBird() {
        var udId = userDefault.objectForKey("adultBirds") as! [Int]
        let n = (Int)(arc4random() % 5)
        //myValue = myValue + 1

        udId.append(n)
        userDefault.setObject(udId, forKey: "adultBirds")
    }

    func setAdultBirdImage(){
        let widthSize = Int(self.view.frame.size.width - 70)
        let highSize = Int(self.view.frame.size.height - 110)
        
        let x = arc4random_uniform(UInt32(widthSize))
        let y = arc4random_uniform(UInt32(highSize))
        
        myImageView = UIImageView(frame: CGRectMake(CGFloat(x),CGFloat(y),50,50))
        if let adultBirds = userDefault.objectForKey("adultBirds") as? [Int] {
            switch adultBirds.last! {
            case 0:
                myImageView.image = UIImage(named: "botton_inko.png")!
                break
            case 1:
                myImageView.image = UIImage(named: "kozakura_inko.png")!
                break
            case 2:
                myImageView.image = UIImage(named: "okame_inko.png")!
                break
            case 3:
                myImageView.image = UIImage(named: "sekisei_inko.png")!
                break
            case 4:
                myImageView.image = UIImage(named: "sekisei2_inko.png")!
                break
            default:
                myImageView.image = UIImage(named: "botton_inko.png")!
                break
            }
        }else{
                myImageView.image = UIImage(named: "botton_inko.png")!
            }
        
        self.view.addSubview(myImageView)
        
        myImageViewArray.append(myImageView)
        
        //アニメーション
        //追加されたとりのズームと移動
        UIImageView.animateWithDuration(0.8,delay:0.2,
            options:UIViewAnimationOptions.CurveEaseOut,
            animations: {() -> Void in
                self.myImageView.transform = CGAffineTransformMakeScale(2.0, 2.0)
                self.myImageView.transform = CGAffineTransformMakeScale(1.0, 1.0)
                self.myImageView.center = CGPointMake(CGFloat(x), CGFloat(y))
            },
            completion: nil
        )
        
        //super.viewDidAppear(1)
        
        //onAnimateImage(myImageView,x: CGFloat(x), y: CGFloat(y))
    }
    
    //アニメーション
    //とりが動く
    
    /*
    func onAnimateImage(target: UIImageView,x: CGFloat,y: CGFloat){
        // 画面1pt進むのにかかる時間の計算
        let timePerSecond = 30.0 / view.bounds.size.width
        
        let widthLength = self.view.bounds.width
        
        // 画像の位置から画面右までにかかる時間の計算
        //let remainTime = (view.bounds.size.width - target.frame.origin.x) * timePerSecond
        let remainTime = arc4random_uniform(UInt32(5))
        // アニメーション
        UIImageView.transitionWithView(target, duration: NSTimeInterval( remainTime), options: .CurveLinear, animations: { () -> Void in
            
            // 画面右まで移動
            target.frame.origin.x = widthLength - 50
            
            }, completion: { _ in
                
                // 画面右まで行ったら、画面左に戻す
                //target.frame.origin.x = target.bounds.size.width
                
                // 再度アニメーションを起動
                self.onAnimateImage(target,x: x,y: y)
        })
    }
*/
    

    @IBAction func didPushCameraButton(sender: AnyObject) {
        hiddenHomeView()
        showCameraView()
    }

//Camera
    func setupCammera() {
        cameraSession = AVCaptureSession()
        
        //デバイス取得
        let devices = AVCaptureDevice.devices()
        for device in devices {
            if device.position == AVCaptureDevicePosition.Back {
                if let d = device as? AVCaptureDevice {
                    myDevice = d
                }
            }
        }
        
        //画像インプット・アウトプット設定
        if let deviceInput = AVCaptureDeviceInput.deviceInputWithDevice(myDevice, error: nil) as? AVCaptureDeviceInput {
             cameraSession.addInput(deviceInput)
        }
        imageOutput = AVCaptureStillImageOutput()
        cameraSession.addOutput(imageOutput)
        
        //画像表示レイヤー設定
        imagePreviewLayer = AVCaptureVideoPreviewLayer.layerWithSession(cameraSession) as! AVCaptureVideoPreviewLayer
        imagePreviewLayer.frame = self.view.bounds
        imagePreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
    }

    func setupTakePhotoButtons() {
        let tabbarHeight = self.tabBarController?.tabBar.frame.size.height;
        
        takePhotoButton = UIButton(frame: CGRectMake(0,0,120,50))
        takePhotoButton.backgroundColor = UIColor.redColor();
        takePhotoButton.layer.masksToBounds = true
        takePhotoButton.setTitle("撮影", forState: .Normal)
        takePhotoButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        takePhotoButton.setTitleColor(UIColor.grayColor(), forState: .Highlighted)
        takePhotoButton.layer.cornerRadius = 20.0
        takePhotoButton.layer.position = CGPoint(x: self.view.bounds.width/2,
                                        y: self.view.bounds.height - takePhotoButton.frame.size.height - tabbarHeight!)
        takePhotoButton.addTarget(self, action: "didPushTakePhotoButton:", forControlEvents: .TouchUpInside)
        
        
        retakePhotoButton = UIButton(frame: CGRectMake(0,0,120,50))
        retakePhotoButton.backgroundColor = UIColor.blueColor();
        retakePhotoButton.layer.masksToBounds = true
        retakePhotoButton.setTitle("やり直す", forState: .Normal)
        retakePhotoButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        retakePhotoButton.setTitleColor(UIColor.grayColor(), forState: .Highlighted)
        retakePhotoButton.layer.cornerRadius = 20.0
        retakePhotoButton.layer.position = CGPoint(x: retakePhotoButton.frame.size.width/2+15,
                                        y: self.view.bounds.height - takePhotoButton.frame.size.height - tabbarHeight!)
        retakePhotoButton.addTarget(self, action: "didPushRetakePhotoButton:", forControlEvents: .TouchUpInside)
        
        decidePhotoButton = UIButton(frame: CGRectMake(0,0,120,50))
        decidePhotoButton.backgroundColor = UIColor.greenColor();
        decidePhotoButton.layer.masksToBounds = true
        decidePhotoButton.setTitle("決定", forState: .Normal)
        decidePhotoButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        decidePhotoButton.setTitleColor(UIColor.grayColor(), forState: .Highlighted)
        decidePhotoButton.layer.cornerRadius = 20.0
        decidePhotoButton.layer.position = CGPoint(x: self.view.frame.size.width - decidePhotoButton.frame.size.width/2-15,
                                        y: self.view.bounds.height - takePhotoButton.frame.size.height - tabbarHeight!)
        decidePhotoButton.addTarget(self, action: "didPushDesidePhotoButton:", forControlEvents: .TouchUpInside)
    }
    
    func setupCameraMessageLabel() {
        cameraMessageLabel = UILabel(frame: CGRectMake(10, 10, self.view.frame.size.width - 20, 50))
        cameraMessageLabel.backgroundColor = UIColor.lightTextColor()
        cameraMessageLabel.layer.masksToBounds = true
        cameraMessageLabel.layer.cornerRadius = 10.0
        //cameraMessageLabel.font = UIFont.systemFontOfSize(7)
        cameraMessageLabel.layer.position = CGPoint(x: self.view.frame.size.width/2, y: 50)
        cameraMessageLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(cameraMessageLabel)
        
        let asaTime = userDefault.objectForKey("asa") as! String
        let hiruTime = userDefault.objectForKey("hiru") as! String
        let yoruTime = userDefault.objectForKey("yoru") as! String
        
        if isMealTime(asaTime) {
             nowTime = 0
             cameraMessageLabel.text = "いまは朝食の時間です (" + asaTime + ")"
        } else if isMealTime(hiruTime) {
             cameraMessageLabel.text = "いまは昼食の時間です (" + hiruTime + ")"
        } else if isMealTime(yoruTime) {
             cameraMessageLabel.text = "いまは夕食の時間です (" + yoruTime + ")"
        } else {
            switch(nowTime){
            case 1:
                cameraMessageLabel.text = "つぎは夕食です(" + yoruTime + ")"
                break;
            case 2:
                cameraMessageLabel.text = "つぎは昼食です(" + hiruTime + ")"
                break;
            case 3:
                cameraMessageLabel.text = "つぎは朝食です(" + asaTime + ")"
                break;
            default:
                cameraMessageLabel.text = "いまはごはんの時間ではありません"
                break;
            }
            //初期化
            nowTime = 0
        }
    }
    
    func isMealTime(time:String) -> Bool {
        let times = time.componentsSeparatedByString("~ ")
        let starts = times[0].componentsSeparatedByString(":")
        let ends = times[1].componentsSeparatedByString(":")
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
        dateFormatter.dateFormat = "HH"
        let now = dateFormatter.stringFromDate(NSDate())
        
        let startHour = starts[0].toInt()!
        let endHour = ends[0].toInt()!
        let nowHour = now.toInt()!
        
        //nowTime = startHour - nowHour
        //if (nowTime > 0){
        if(0<(startHour-nowHour)){
            nowTime = nowTime + 1
        }
       
        if startHour <= nowHour && nowHour < endHour {
            return true
        } else {
            return false
        }
    }
    
    func didPushTakePhotoButton(sender: AnyObject) {
        
        let cameraConnection = imageOutput.connectionWithMediaType(AVMediaTypeVideo)
        self.imageOutput.captureStillImageAsynchronouslyFromConnection(cameraConnection, completionHandler: { (imageDataBuffer, error) -> Void in
            
            let imageJpgData : NSData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataBuffer)
            let image : UIImage = UIImage(data: imageJpgData)!
            self.photoPreviewImageView.image = image
            self.mealPhoto.image = image
            self.hiddenCameraView()
            self.showPhotoPreview()
        })
    }
    
    func showCameraView() {
        self.view.layer.addSublayer(imagePreviewLayer)
        cameraSession.startRunning()
        self.view.addSubview(takePhotoButton)
        cameraMessageLabel.hidden = false
    }
    
    func hiddenCameraView() {
         cameraSession.stopRunning()
         imagePreviewLayer.removeFromSuperlayer()
         takePhotoButton.removeFromSuperview()
         cameraMessageLabel.hidden = true
    }
    
    func showPhotoPreview() {
        self.photoPreviewImageView.hidden = false;
        self.view.addSubview(retakePhotoButton)
        self.view.addSubview(decidePhotoButton)
        cameraMessageLabel.hidden = false
    }
    
    func hiddenPhotoPreview() {
        photoPreviewImageView.hidden = true;
        photoPreviewImageView.image = nil;
        retakePhotoButton.removeFromSuperview()
        decidePhotoButton.removeFromSuperview()
        cameraMessageLabel.hidden = true
    }
    
    func setupHomeView() {
        showBird()
        photoPreviewImageView.hidden = false
        photoPreviewImageView.image = UIImage(named: "bg_hiru.png")
        messageLabel.hidden = false
        cameraButton.hidden = false
        cameraMessageLabel.hidden = true
        for imageView in myImageViewArray {
            imageView.hidden = false
        }
    }
    
    func hiddenHomeView() {
        photoPreviewImageView.hidden = true
        photoPreviewImageView.image = nil
        messageLabel.hidden = true
        cameraButton.hidden = true
        birdImageView.removeFromSuperview()
        for imageView in myImageViewArray {
            imageView.hidden = true
        }
    }
    
    func didPushRetakePhotoButton(sender: AnyObject) {
        hiddenPhotoPreview()
        showCameraView()
    }
    
    func didPushDesidePhotoButton(sender: AnyObject) {
        let image = self.photoPreviewImageView.image
        let photo = Photo.MR_createEntity()
        photo.image = NSData(data: UIImagePNGRepresentation(image))
        photo.date = NSDate()
        photo.managedObjectContext?.MR_saveToPersistentStoreAndWait()
        
        hiddenPhotoPreview()
        setupHomeView()
        
        let asaTime = userDefault.objectForKey("asa") as! String
        let hiruTime = userDefault.objectForKey("hiru") as! String
        let yoruTime = userDefault.objectForKey("yoru") as! String
        if isMealTime(asaTime) || isMealTime(hiruTime) || isMealTime(yoruTime){
            eatPhoto()
        }
    }
    
    func showBird() {
        if let count = userDefault.objectForKey("count") as? Int {
            birdImageView.image = getBirdImage(count)
        } else {
            birdImageView.image = getBirdImage(0)
        }
        self.view.addSubview(birdImageView)
    }
    
    func eatPhoto() {
        self.view.addSubview(mealPhoto)
        UIView.animateWithDuration(2.5, animations: { () -> Void in
            let tabbarHeight = self.tabBarController?.tabBar.frame.size.height;
            let scale = CGAffineTransformMakeScale(0.01, 0.01)
            let transition = CGAffineTransformMakeTranslation(self.view.frame.width/2-self.mealPhoto.bounds.size.width/2 - 85, self.view.frame.size.height - tabbarHeight! - 330)
            let rotateScale = CGAffineTransformRotate(scale, CGFloat(180 * M_PI / 180))
            self.mealPhoto.transform = CGAffineTransformConcat(rotateScale, transition)
        }, completion: {(Bool) -> Void in
            self.didAddPhoto()
            self.mealPhoto.removeFromSuperview()
            self.mealPhoto.transform = CGAffineTransformIdentity
        })
        
    }
    
    func checkData() {
        let photos = Photo.MR_findAll()
        for photo in photos {
            if let p = photo as? Photo {
                print("image：")
                println(photo.image)
                print("date：")
                println(photo.date)
            }
        }
    }
    
}
