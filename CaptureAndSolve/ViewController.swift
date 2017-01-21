//
//  ViewController.swift
//  CaptureAndSolve
//
//  Created by Aryal, Surabhya on 11/22/16.
//  Copyright © 2016 Aryal, Surabhya. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let firstImagePicker = UIImagePickerController()
    let secondImagePicker = UIImagePickerController()
    
    // First Picture
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var firstGalleryButton: UIBarButtonItem!
    @IBOutlet weak var firstCameraButton: UIBarButtonItem!
    
    // Second Picture
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var secondGalleryButton: UIBarButtonItem!
    @IBOutlet weak var secondCameraButton: UIBarButtonItem!
    
    // Spinner
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // Analyze Image
    @IBOutlet weak var analyzeImageButton: UIBarButtonItem!
    
    // Boolean value to determine image picker.
    var isFirstImageView = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        firstImagePicker.delegate = self
        secondImagePicker.delegate = self
        self.analyzeImageButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        firstCameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        secondCameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        spinner.hidesWhenStopped = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pickFirstImage(_ sender: AnyObject) {
        isFirstImageView = true;
        firstImagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        present(firstImagePicker, animated: true, completion: nil)
    }
    
    @IBAction func clickFirstImage(_ sender: AnyObject) {
        isFirstImageView = true;
        firstImagePicker.sourceType = UIImagePickerControllerSourceType.camera
        self.present(firstImagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickSecondImage(_ sender: AnyObject) {
        isFirstImageView = false;
        secondImagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        present(secondImagePicker, animated: true, completion: nil)
    }
    
    @IBAction func clickSecondImage(_ sender: AnyObject) {
        isFirstImageView = false;
        secondImagePicker.sourceType = UIImagePickerControllerSourceType.camera
        self.present(secondImagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func analyzeImage(_ sender: AnyObject) {
        self.analyzeImageButton.isEnabled = false
        self.disableUI(boolean: true)
        if let binaryFirstImageData = base64EncodeImage(firstImageView.image!) as Optional {
            createRequest(with: binaryFirstImageData as String)
        }
        if let binarySecondImageData = base64EncodeImage(secondImageView.image!) as Optional {
            createRequest(with: binarySecondImageData as String)
        }
        self.analyzeImageButton.isEnabled = true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            if isFirstImageView {
                self.firstImageView.image = pickedImage
            } else {
                self.secondImageView.image = pickedImage
            }
        }
        dismiss(animated: true, completion: nil)
        if (self.firstImageView.image != nil && self.secondImageView.image != nil){
            self.analyzeImageButton.isEnabled = true
        }
    }
    
    func imagePickerControllerDidCancel(_: UIImagePickerController){
        dismiss(animated: true, completion: nil)
    }
    
    func disableUI(boolean : Bool){
        if boolean {
            self.spinner.startAnimating()
            self.firstCameraButton.isEnabled = !boolean
            self.firstGalleryButton.isEnabled = !boolean
            self.secondCameraButton.isEnabled = !boolean
            self.secondGalleryButton.isEnabled = !boolean
        } else {
            self.spinner.stopAnimating()
            self.firstCameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
            self.firstGalleryButton.isEnabled = !boolean
            self.secondCameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
            self.secondGalleryButton.isEnabled = !boolean
        }
    }
    
    func loadImageString(textInImage : String){
        performUIUpdatesOnMain{
            self.disableUI(boolean: false)
            self.spinner.hidesWhenStopped = true
        }
        print("Text from the image\n \(textInImage)")
    }
}
