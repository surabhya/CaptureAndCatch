//
//  Constants.swift
//  CaptureAndSolve
//
//  Created by Aryal, Surabhya on 11/25/16.
//  Copyright © 2016 Aryal, Surabhya. All rights reserved.
//

struct Constants {
    

    struct GoogleVision {
        static let APIKey = "AIzaSyB1dHWERwZ6IKbIRTjoWwFZlKr33PYfuTY"
        static let ApiScheme = "https"
        static let ApiHost = "vision.googleapis.com"
        static let ApiPath = "/v1/images:annotate"
    }
    
    struct Dandelion {
        static let APIKey = "5efb6212b4f045d2ae10ff42b24bf2fd"
        static let ApiScheme = "https"
        static let ApiHost = "api.dandelion.eu"
        static let ApiPath = "/datatxt/sim/v1/"
        
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
    
    // MARK: Dandelion Parameter Keys
    struct DandelionParameterURLKeys {
        static let TEXT1 = "text1"
        static let TEXT2 = "text2"
        static let TOKEN = "token"
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
    
    // MARK: Dandelion Response Keys
    struct DandelionResponseKeys {
        static let TIME = "time"
        static let SIMILARITY = "similarity"
        static let LANG = "lang"
        static let LANG_CONFIDENCE = "langConfidence"
        static let TIME_STAMP = "timestamp"
        static let OPTIONAL = "Optional"
    }
}

