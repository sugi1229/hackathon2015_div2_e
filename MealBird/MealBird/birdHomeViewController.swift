//
//  birdHomeViewController.swift
//  MealBird
//
//  Created by minami on 8/16/15.
//  Copyright (c) 2015 div2_e. All rights reserved.
//

import UIKit
import AVFoundation

class birdHomeViewController: UIViewController {

    var cameraSession : AVCaptureSession!
    var myDevice : AVCaptureDevice!
    var imageOutput : AVCaptureStillImageOutput!
    var imagePreviewLayer : AVCaptureVideoPreviewLayer!
    var takePhotoButton : UIButton!
    var retakePhotoButton : UIButton!
    var decidePhotoButton : UIButton!
    
     let userDefault = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var photoPreviewImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.setupCammera()
        self.setupTakePhotoButtons()
        self.hiddenPhotoPreview()
        self.showCameraView()
        
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
    
    @IBAction func didPushGohanButton(sender: AnyObject) {
        var count = 0
        if let prevCount = userDefault.objectForKey("count") as? Int {
            count = (prevCount + 1) % 10
        }
        userDefault.setObject(count, forKey: "count")
        
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
