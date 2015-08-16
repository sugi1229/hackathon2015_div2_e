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
    
    var birdImageView : UIImageView!
    @IBOutlet weak var cameraButton: UIButton!
    
    private var myImageView: UIImageView!
    private var myImageViewArray: [UIImageView] = []
    private var myImage: UIImage!
    
    private var myValue: Int!
    
    let userDefault = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var photoPreviewImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupCammera()
        setupTakePhotoButtons()
        hiddenPhotoPreview()
        showCameraView()
        setupCameraMessageLabel()
        
        setupMessageLabel()
        
        if let adultBirds = userDefault.objectForKey("adultBirds") as? [Int] {
            print("adultBirds")
            println(adultBirds.last)
        } else {
            let n = (Int)(arc4random() % 5)
            let adultBirds : [Int] = [n]
            userDefault.setObject(adultBirds, forKey: "adultBirds")
        }

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
        
        //成長後
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
        let tabbarHeight = self.tabBarController?.tabBar.frame.size.height;
        birdImageView = UIImageView(frame: CGRectMake(self.view.frame.width/2, self.view.frame.size.height-tabbarHeight! - 52, 50, 50))
        birdImageView.contentMode = UIViewContentMode.ScaleAspectFill
        if let count = userDefault.objectForKey("count") as? Int {
            birdImageView.image = getBirdImage(count)
        } else {
            birdImageView.image = getBirdImage(0)
        }
        self.view.addSubview(birdImageView)
    }

    func getBirdImage(count: Int) -> UIImage {
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
            setBirdImage()
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

    func setBirdImage(){
        let widthSize = Int(self.view.frame.size.width - 70)
        let highSize = Int(self.view.frame.size.height - 110)
        
        //var x = Int(arc4random()) % widthSize
        //var y = Int(arc4random()) % highSize
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
    }


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
        cameraMessageLabel.layer.position = CGPoint(x: self.view.frame.size.width/2, y: 50)
        cameraMessageLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(cameraMessageLabel)
        
        let asaTime = userDefault.objectForKey("asa") as! String
        let hiruTime = userDefault.objectForKey("hiru") as! String
        let yoruTime = userDefault.objectForKey("yoru") as! String
        
        if isMealTime(asaTime) {
             cameraMessageLabel.text = "いまは朝食の時間です"
        } else if isMealTime(hiruTime) {
             cameraMessageLabel.text = "いまは昼食の時間です"
        } else if isMealTime(yoruTime) {
             cameraMessageLabel.text = "いまは夕食の時間です"
        } else {
             cameraMessageLabel.text = "いまはごはんの時間ではありません"
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
            self.photoPreviewImageView.image = image;
            
            self.hiddenCameraView()
            self.showPhotoPreview()
        })
    }
    
    func showCameraView() {
        self.view.layer.addSublayer(imagePreviewLayer)
        cameraSession.startRunning()
        self.view.addSubview(takePhotoButton)
    }
    
    func hiddenCameraView() {
         cameraSession.stopRunning()
         imagePreviewLayer.removeFromSuperlayer()
         takePhotoButton.removeFromSuperview()
    }
    
    func showPhotoPreview() {
        self.photoPreviewImageView.hidden = false;
        self.view.addSubview(retakePhotoButton)
        self.view.addSubview(decidePhotoButton)
    }
    
    func hiddenPhotoPreview() {
        photoPreviewImageView.hidden = true;
        photoPreviewImageView.image = nil;
        retakePhotoButton.removeFromSuperview()
        decidePhotoButton.removeFromSuperview()
    }
    
    func setupHomeView() {
        photoPreviewImageView.hidden = false
        photoPreviewImageView.image = UIImage(named: "bg_hiru.png")
        messageLabel.hidden = false
        cameraButton.hidden = false
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
        cameraMessageLabel.hidden = true
        hiddenPhotoPreview()
        setupHomeView()
        setupBird()
        
        let asaTime = userDefault.objectForKey("asa") as! String
        let hiruTime = userDefault.objectForKey("hiru") as! String
        let yoruTime = userDefault.objectForKey("yoru") as! String
        if isMealTime(asaTime) || isMealTime(hiruTime) || isMealTime(yoruTime){
            didAddPhoto()
        }
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
