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
    @IBOutlet weak var similarityConfidence: UITextView!
    
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
            self.firstImageTextView.text = "Text from Primary Image:\n\n\(self.textFromFirstImage)"
            self.secondImageTextView.text = "Text from Secondary Image:\n\n\(self.textFromSecondImage)"
            self.similarityConfidence.text = "Similarity Coefficient:\n\(String(self.textSimilarity))"
            if(self.textSimilarity<0.5){
                self.similarityConfidence.textColor = UIColor.green
            }
            else{
                self.similarityConfidence.textColor = UIColor.red
            }
        }
    }
    
    
}
