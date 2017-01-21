//
//  FirstImagePicker.swift
//  CaptureAndSolve
//
//  Created by Aryal, Surabhya on 1/18/17.
//  Copyright © 2017 Aryal, Surabhya. All rights reserved.
//

import Foundation

import UIKit

class FirstImagePicker: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    

    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pickAnImage(_ sender: AnyObject) {
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func clickAnImage(_ sender: AnyObject) {
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
        self.enableUI(boolean: false)
//        if let binaryImageData = base64EncodeImage(imageView.image!) as Optional {
//            createRequest(with: binaryImageData as String)
//        }
    }
    
    func imagePickerControllerDidCancel(_: UIImagePickerController){
        dismiss(animated: true, completion: nil)
    }
    
    func parseImageString(textInImage : String){
        performUIUpdatesOnMain{
            self.enableUI(boolean: true)
        }
    }
    
    func enableUI(boolean : Bool){
        self.cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        self.galleryButton.isEnabled = boolean
    }
}
