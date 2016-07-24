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
    override func viewDidLoad() {
        super.viewDidLoad()
        let backItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backItem
        generate()
        self.tabBarController?.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            print("A")
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
