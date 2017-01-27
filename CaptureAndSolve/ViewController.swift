//
//  ViewController.swift
//  CaptureAndSolve
//
//  Created by Aryal, Surabhya on 11/22/16.
//  Copyright © 2016 Aryal, Surabhya. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Image Picker Controller
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
    
    // Text from the image.
    var textFromFirstImage: String = ""
    var textFromSecondImage: String = ""
    
    // Text from the image processed.
    var textFromFirstImageProcessed: Bool = false
    var textFromSecondImageProcessed: Bool = false
    
    // Similarity for two images.
    var similarity = -1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.firstImagePicker.delegate = self
        self.secondImagePicker.delegate = self
        self.analyzeImageButton.isEnabled = false
        self.textFromFirstImage = ""
        self.textFromSecondImage = ""
        self.textFromFirstImageProcessed = false
        self.textFromSecondImageProcessed = false
        self.similarity = -1.0
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
        self.disableUI(boolean: true)
        
        //        let queue = OperationQueue()
        //
        //        let operationGetTextFromFirstImage = BlockOperation(block: {
        //            OperationQueue.main.addOperation({
        //                if let binaryFirstImageData = self.base64EncodeImage(self.firstImageView.image!) as Optional {
        //                    self.createRequest(with: binaryFirstImageData as String, imageView: self.firstImageView)
        //                }
        //            })
        //        })
        //
        //        let operationGetTextFromSecondImage = BlockOperation(block: {
        //            OperationQueue.main.addOperation({
        //                if let binarySecondImageData = self.base64EncodeImage(self.secondImageView.image!) as Optional {
        //                    self.createRequest(with: binarySecondImageData as String, imageView: self.secondImageView)
        //                }
        //            })
        //        })
        //
        //        let operationGetSimilairyConfidence = BlockOperation(block: {
        //            OperationQueue.main.addOperation({
        //                if self.textFromFirstImageProcessed && self.textFromSecondImageProcessed {
        //                    self.createRequest(with: self.textFromFirstImage, text2: self.textFromSecondImage)
        //                }
        //            })
        //        })
        //
        //        operationGetTextFromFirstImage.completionBlock = {
        //            operationGetTextFromSecondImage.completionBlock = {
        //                operationGetSimilairyConfidence.completionBlock = {
        //                    print("operationGetSimilairyConfidence completed")
        //                }
        //                queue.addOperation(operationGetSimilairyConfidence)
        //            }
        //            queue.addOperation(operationGetTextFromSecondImage)
        //        }
        //        queue.addOperation(operationGetTextFromFirstImage)
        
        
        if let binaryFirstImageData = base64EncodeImage(firstImageView.image!) as Optional {
            createRequest(with: binaryFirstImageData as String, imageView: firstImageView)
        }
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
            self.analyzeImageButton.isEnabled = !boolean
        } else {
            self.spinner.stopAnimating()
            self.firstCameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
            self.firstGalleryButton.isEnabled = !boolean
            self.secondCameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
            self.secondGalleryButton.isEnabled = !boolean
            self.analyzeImageButton.isEnabled = !boolean
        }
    }
    
    func getStringFromImage(textInImage : String, imageView: UIImageView){
        if imageView == self.firstImageView {
            self.textFromFirstImage = textInImage
            self.textFromFirstImageProcessed = true
            if let binarySecondImageData = base64EncodeImage(secondImageView.image!) as Optional {
                createRequest(with: binarySecondImageData as String, imageView: secondImageView)
            }
        }else if imageView == self.secondImageView{
            self.textFromSecondImage = textInImage
            self.textFromSecondImageProcessed = true
            if self.textFromFirstImageProcessed && self.textFromSecondImageProcessed {
                createRequest(with: self.textFromFirstImage, text2: self.textFromSecondImage)
            }
        }
    }
    
    func getSimilarityFromText(similarity : Double){
        performUIUpdatesOnMain{
            self.disableUI(boolean: false)
            self.spinner.hidesWhenStopped = true
        }
        self.similarity = similarity
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let similarityViewController = segue.destination as? SimilarityViewController {
            similarityViewController.textFromFirstImage = self.textFromFirstImage
            similarityViewController.textFromSecondImage = self.textFromSecondImage
            similarityViewController.textSimilarity = self.similarity
        }
    }
    
}
