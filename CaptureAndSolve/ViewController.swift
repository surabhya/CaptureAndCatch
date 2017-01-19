//
//  ViewController.swift
//  CaptureAndSolve
//
//  Created by Aryal, Surabhya on 11/22/16.
//  Copyright © 2016 Aryal, Surabhya. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var galleryButton: UIBarButtonItem!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var textView: UITextView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        textView.delegate = self
        textView.text = "Please select an image"
        textView.isEditable = false
        textView.textAlignment = .center
    }

    override func viewWillAppear(_ animated: Bool) {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        spinner.hidesWhenStopped = true
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
        if let binaryImageData = base64EncodeImage(imageView.image!) as Optional {
            createRequest(with: binaryImageData as String)
        }
        self.textView.text = "Processing image"
        self.textView.textColor = UIColor.black
    }
    
    func imagePickerControllerDidCancel(_: UIImagePickerController){
        dismiss(animated: true, completion: nil)
    }
    
    func parseImageString(textInImage : String){
        let arrayOfEquation = textInImage.characters.split(separator: "\n")
        performUIUpdatesOnMain{
            if arrayOfEquation.count == 0 {
                self.textView.text = "No text found.\nPlease select another image."
                self.textView.textColor = UIColor.red
            }else{
                self.textView.text = textInImage
                self.textView.textColor = UIColor.green
            }
            self.enableUI(boolean: true)
        }
    }
    
    func enableUI(boolean : Bool){
        self.cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        self.galleryButton.isEnabled = boolean
        if !boolean {
            self.spinner.startAnimating()
        } else {
            self.spinner.stopAnimating()
        }
    }
}

