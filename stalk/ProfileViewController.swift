//
//  ProfileViewController.swift
//  stalk
//
//  Created by Jun Hong on 7/24/16.
//  Copyright © 2016 carl. All rights reserved.
//

import UIKit
import QRCodeReaderViewController
import RAMAnimatedTabBarController

class ProfileViewController: UIViewController, UITabBarControllerDelegate {

    @IBOutlet weak var qrcodeImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    var sidebar: FrostedSidebar!
    
    static var profileImage: UIImage = UIImage(named: "avatar1")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generate()
        // Do any additional setup after loading the view.
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(ProfileViewController.imageTapped(_:)))
        profileImageView.userInteractionEnabled = true
        profileImageView.addGestureRecognizer(tapGestureRecognizer)
        
        profileImageView.image = ProfileViewController.profileImage
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imageTapped(sender:AnyObject?) {
        
        sidebar = FrostedSidebar(itemImages: [
            UIImage(named: "ElectricGuitar")!,
            UIImage(named: "AcousticGuitar")!,
            UIImage(named: "Drum")!,
            UIImage(named: "Mixer")!,
            UIImage(named: "Keyboard")!],
                                 colors: [
                                    UIColor(red: 240/255, green: 159/255, blue: 254/255, alpha: 1),
                                    UIColor(red: 255/255, green: 137/255, blue: 167/255, alpha: 1),
                                    UIColor(red: 200/255, green: 242/255, blue: 100/255, alpha: 1),
                                    UIColor(red: 126/255, green: 242/255, blue: 195/255, alpha: 1),
                                    UIColor(red: 119/255, green: 152/255, blue: 255/255, alpha: 1)],
                                 selectionStyle: .Single)
        sidebar.actionForIndex = [
            0: {self.profileImageView.image = UIImage(named: "ElectricGuitar")!
                self.profileImageView.backgroundColor = UIColor(red: 240/255, green: 159/255, blue: 254/255, alpha: 1)
                self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.height/2
                self.profileImageView.layer.masksToBounds = true
                self.profileImageView.layer.borderWidth = 0
                self.profileImageView.contentMode = .Center
                ProfileViewController.profileImage = UIImage(named: "ElectricGuitar")!
            },
            1: {self.profileImageView.image = UIImage(named: "AcousticGuitar")!
                self.profileImageView.backgroundColor = UIColor(red: 255/255, green: 137/255, blue: 167/255, alpha: 1)
                self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.height/2
                self.profileImageView.layer.masksToBounds = true
                self.profileImageView.layer.borderWidth = 0
                self.profileImageView.contentMode = .Center
                ProfileViewController.profileImage = UIImage(named: "AcousticGuitar")!
            },
            2: {self.profileImageView.image = UIImage(named: "Drum")!
                self.profileImageView.backgroundColor = UIColor(red: 200/255, green: 242/255, blue: 100/255, alpha: 1)
                self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.height/2
                self.profileImageView.layer.masksToBounds = true
                self.profileImageView.layer.borderWidth = 0
                self.profileImageView.contentMode = .Center
                ProfileViewController.profileImage = UIImage(named: "Drum")!
            },
            3: {self.profileImageView.image = UIImage(named: "Mixer")!
                self.profileImageView.backgroundColor = UIColor(red: 126/255, green: 242/255, blue: 135/255, alpha: 1)
                self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.height/2
                self.profileImageView.layer.masksToBounds = true
                self.profileImageView.layer.borderWidth = 0
                self.profileImageView.contentMode = .Center
                ProfileViewController.profileImage = UIImage(named: "Mixer")!
            },
            4: {self.profileImageView.image = UIImage(named: "Keyboard")!
                self.profileImageView.backgroundColor = UIColor(red: 119/255, green: 152/255, blue: 255/255, alpha: 1)
                self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.height/2
                self.profileImageView.layer.masksToBounds = true
                self.profileImageView.layer.borderWidth = 0
                self.profileImageView.contentMode = .Center
                ProfileViewController.profileImage = UIImage(named: "Keyboard")!
            }]
        
        sidebar.showInViewController(self.navigationController!, animated: true)
        

    }

    
    func generate(){
        qrcodeImageView.image = nil
        var qrcodeImage: CIImage! = nil
        let string = "string"
        let data = string.dataUsingEncoding(NSISOLatin1StringEncoding, allowLossyConversion: false)
        
        
        let filter = CIFilter(name: "CIQRCodeGenerator")
        
        filter!.setValue(data, forKey: "inputMessage")
        filter!.setValue("Q", forKey: "inputCorrectionLevel")
        
        qrcodeImage = filter!.outputImage
        
        
        let scaleX = qrcodeImageView.frame.size.width / qrcodeImage!.extent.size.width
        let scaleY = qrcodeImageView.frame.size.height / qrcodeImage!.extent.size.height
        
        let transformedImage = qrcodeImage!.imageByApplyingTransform(CGAffineTransformMakeScale(scaleX, scaleY))
        
        qrcodeImageView.image = UIImage(CIImage: transformedImage)
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        if (viewController is PhotoViewController) {
            print("ya")
            let reader:QRCodeReader = QRCodeReader.init(metadataObjectTypes: [AVMetadataObjectTypeQRCode])
            let vcQR = QRCodeReaderViewController.readerWithCancelButtonTitle("Cancel", codeReader: reader, startScanningAtLoad: true, showSwitchCameraButton: true, showTorchButton: true)
            vcQR.modalPresentationStyle = UIModalPresentationStyle.FormSheet
            vcQR.delegate = self.tabBarController!
            reader.setCompletionWithBlock({ (result:String!) -> () in
                print(result)
            })
            self.tabBarController!.presentViewController(vcQR, animated: true, completion: nil)
            return false
        } else {
            return true
        }
    }
}


extension UIViewController: QRCodeReaderDelegate {
    
    // MARK : QRCodeReader Delegate Methods
    public func reader(reader: QRCodeReaderViewController!, didScanResult result: String!) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    public func readerDidCancel(reader: QRCodeReaderViewController!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}

extension UIColor {
    static func color(red: Int, green: Int, blue: Int, alpha: Float) -> UIColor {
        return UIColor(
            colorLiteralRed: Float(1.0) / Float(255.0) * Float(red),
            green: Float(1.0) / Float(255.0) * Float(green),
            blue: Float(1.0) / Float(255.0) * Float(blue),
            alpha: alpha)
    }
}
