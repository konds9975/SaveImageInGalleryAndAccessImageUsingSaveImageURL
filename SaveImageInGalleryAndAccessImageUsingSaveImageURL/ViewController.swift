//
//  ViewController.swift
//  SelfieTime
//
//  Created by Andrew Seeley on 11/09/2016.
//  Copyright © 2016 Seemu. All rights reserved.
//

import UIKit
import Photos
import AssetsLibrary

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet var myImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(PHPhotoLibrary.shared().fetchAssetCollectionForAlbum(name: "Fabbit"))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func takePhoto(_ sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            myImg.contentMode = .scaleToFill
            myImg.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func savePhoto(_ sender: AnyObject) {
       
        PHPhotoLibrary.shared().savePhoto(image: myImg.image!, albumName: "Fabbit"){ (image)in
            
            print(PHPhotoLibrary.shared().getURL(ofPhotoWith: image!, completionHandler: { (url) in
                print(url ?? "nn")
                
                do{
                    let catPictureData = try Data(contentsOf: url!)
                    let catPicture = UIImage(data: catPictureData )
                    self.image3.image = catPicture
                }catch
                {
                    print(error)
                }
                
            }))
        }
        
        let alert = UIAlertController(title: "Saved", message: "Your image has been saved", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
        
        
        
        
    }
    
    
}

