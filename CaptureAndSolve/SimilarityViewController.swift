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
    var textSimilarity: Double = -1.0
    
    // Text view to display image text on the screen.
    @IBOutlet weak var firstImageTextView: UITextView!
    @IBOutlet weak var secondImageTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.updateTextView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateTextView(){
        performUIUpdatesOnMain{
            self.firstImageTextView.text = "Below is text similarity"
            self.secondImageTextView.text = String(self.textSimilarity)
            print("First  \(self.textFromFirstImage)")
            print("Second  \(self.textFromSecondImage)")
            print("Similarity \(self.textSimilarity)")
        }
    }
    
    
}
