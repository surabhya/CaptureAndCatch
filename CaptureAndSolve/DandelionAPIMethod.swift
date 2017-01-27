//
//  DandelionAPIMethod.swift
//  CaptureAndSolve
//
//  Created by Aryal, Surabhya on 1/25/17.
//  Copyright © 2017 Aryal, Surabhya. All rights reserved.
//

import UIKit
import Foundation

extension ViewController {
    
    private func getDandelionURL(text1: String, text2: String) -> URL {
        
        var components = URLComponents()
        components.scheme = Constants.Dandelion.ApiScheme
        components.host = Constants.Dandelion.ApiHost
        components.path = Constants.Dandelion.ApiPath
        components.queryItems = [URLQueryItem]()
        
        let queryItemText1 = URLQueryItem(name: Constants.DandelionParameterURLKeys.TEXT1, value: text1)
        components.queryItems!.append(queryItemText1)
        let queryItemText2 = URLQueryItem(name: Constants.DandelionParameterURLKeys.TEXT2, value: text2)
        components.queryItems!.append(queryItemText2)
        let queryItemToekn = URLQueryItem(name: Constants.DandelionParameterURLKeys.TOKEN, value: "\(Constants.Dandelion.APIKey)")
        components.queryItems!.append(queryItemToekn)
        
        return components.url!
    }
    
    func createRequest(with text1: String, text2: String) {
        
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: getDandelionURL(text1: text1, text2: text2))
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(Bundle.main.bundleIdentifier ?? "", forHTTPHeaderField: "X-Ios-Bundle-Identifier")
        
        var similarity = -1.0
        
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

            if let response =  parsedResult["similarity"] as? Double {
                similarity = response
            }
            
            self.getSimilarityFromText(similarity: similarity)
        }
        task.resume()
    }
}
