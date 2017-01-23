//
//  SimilarityViewController.swift
//  CaptureAndSolve
//
//  Created by Aryal, Surabhya on 1/22/17.
//  Copyright © 2017 Aryal, Surabhya. All rights reserved.
//

import UIKit

class SimilarityViewController: UIViewController {
    
    // Variable to store text from the images.
    var textFromFirstImage: String = ""
    var textFromSecondImage: String = ""
    
    // Text view to display image text on the screen.
    @IBOutlet weak var firstImageTextView: UITextView!
    @IBOutlet weak var secondImageTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("First \(self.textFromFirstImage)")
        self.updateTextView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateTextView(){
        performUIUpdatesOnMain{
            self.firstImageTextView.text = self.textFromFirstImage
            self.secondImageTextView.text = self.textFromSecondImage
            print("Second \(self.textFromSecondImage)")
        }
    }
    
    
}
