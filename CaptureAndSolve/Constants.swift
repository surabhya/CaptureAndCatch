//
//  Constants.swift
//  CaptureAndSolve
//
//  Created by Aryal, Surabhya on 11/25/16.
//  Copyright © 2016 Aryal, Surabhya. All rights reserved.
//

struct Constants {
    

    struct GoogleVision {
        static let APIKey = "AIzaSyBwdB9V_Q6D2skk3QvXtupHuW8ZffVPmxE"
        static let ApiScheme = "https"
        static let ApiHost = "vision.googleapis.com"
        static let ApiPath = "/v1/images:annotate"
    }
    

    // MARK: Vision Parameter Keys
    struct VisionParameterURLKeys {
        static let REQUESTS = "requests"
        static let IMAGE = "image"
        static let CONTENT = "content"
        static let FEATURES = "features"
        static let TYPE = "type"
        static let MAX_RESULTS = "maxResults"
        static let KEY = "key"
    }
    
    // MARK: Vision Parameter Keys
    struct VisionParameterFeatureTypeKeys {
        static let TYPE_UNSPECIFIED = "TYPE_UNSPECIFIED"
        static let FACE_DETECTION = "FACE_DETECTION"
        static let LANDMARK_DETECTION = "LANDMARK_DETECTION"
        static let LOGO_DETECTION = "LOGO_DETECTION"
        static let LABEL_DETECTION = "LABEL_DETECTION"
        static let TEXT_DETECTION = "TEXT_DETECTION"
        static let SAFE_SEARCH_DETECTION = "SAFE_SEARCH_DETECTION"
    }
    
    // MARK: Vision Response Keys
    struct VisionResponseKeys {
        static let TEXT_ANNOTATIONS = "textAnnotations"
        static let DESCRIPTION = "description"
        static let RESPONSES = "responses"
    }
    
}

