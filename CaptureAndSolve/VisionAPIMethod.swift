//
//  VisionAPIMethod.swift
//  CaptureAndSolve
//
//  Created by Aryal, Surabhya on 11/25/16.
//  Copyright © 2016 Aryal, Surabhya. All rights reserved.
//

import UIKit
import Foundation

extension ViewController {
    
    func base64EncodeImage(_ image: UIImage) -> String {
        var imagedata = UIImagePNGRepresentation(image)
        
        // Resize the image if it exceeds the 2MB API limit
        if ((imagedata?.count)! > 2097152) {
            let oldSize: CGSize = image.size
            let newSize: CGSize = CGSize(width: 800, height: oldSize.height / oldSize.width * 800)
            imagedata = resizeImage(newSize, image: image)
        }
        return imagedata!.base64EncodedString(options: .endLineWithCarriageReturn)
    }
    
    func resizeImage(_ imageSize: CGSize, image: UIImage) -> Data {
        UIGraphicsBeginImageContext(imageSize)
        image.draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        let resizedImage = UIImagePNGRepresentation(newImage!)
        UIGraphicsEndImageContext()
        return resizedImage!
    }
    
    private func getVisionURL() -> URL {
        
        var components = URLComponents()
        components.scheme = Constants.GoogleVision.ApiScheme
        components.host = Constants.GoogleVision.ApiHost
        components.path = Constants.GoogleVision.ApiPath
        components.queryItems = [URLQueryItem]()
        
        let queryItem = URLQueryItem(name: Constants.VisionParameterURLKeys.KEY, value: "\(Constants.GoogleVision.APIKey)")
        components.queryItems!.append(queryItem)
        return components.url!
    }
    
    func createRequest(with imageBase64: String, imageView: UIImageView) {
        
        let session = URLSession.shared
        let jsonBody = "{\"\(Constants.VisionParameterURLKeys.REQUESTS)\":[{\"\(Constants.VisionParameterURLKeys.IMAGE)\":{\"\(Constants.VisionParameterURLKeys.CONTENT)\":\"\(imageBase64)\"},\"\(Constants.VisionParameterURLKeys.FEATURES)\":[{\"type\":\"\(Constants.VisionParameterFeatureTypeKeys.TEXT_DETECTION)\",\"\(Constants.VisionParameterURLKeys.MAX_RESULTS)\":10}]}]}"
        
        let request = NSMutableURLRequest(url: getVisionURL())
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(Bundle.main.bundleIdentifier ?? "", forHTTPHeaderField: "X-Ios-Bundle-Identifier")
        request.httpBody = jsonBody.data(using: String.Encoding.utf8)
                
        var textInImage = ""
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            func displayError(_ error: String) {
                print(error)
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                displayError("There was an error with your request: \(error)")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                displayError("No data was returned by the request!")
                return
            }
            
            // parse the data
            let parsedResult: [String:AnyObject]!
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:AnyObject]
            } catch {
                displayError("Could not parse the data as JSON: '\(data)'")
                return
            }
            
            if let responses =  parsedResult[Constants.VisionResponseKeys.RESPONSES] as? [[String:AnyObject]]{
                let response = responses[0]
                if let textAnnotations = response[Constants.VisionResponseKeys.TEXT_ANNOTATIONS] {
                    let textAnnotation = (textAnnotations as? [[String:AnyObject]])?[0]
                    if let description = textAnnotation?[Constants.VisionResponseKeys.DESCRIPTION] {
                        textInImage = description as! String
                    }
                }
            }
            self.getStringFromImage(textInImage: textInImage, imageView: imageView)
        }
        task.resume()
    }
}
