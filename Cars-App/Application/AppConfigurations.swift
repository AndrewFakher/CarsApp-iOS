//
//  AppConfigurations.swift
//  Cars-App
//
//  Created by Andrew on 2/20/22.
//

import Foundation
class AppConfigurations {
    static let apiKey = Bundle.main.object(forInfoDictionaryKey: "ApiKey") as! String
    static let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "ApiBaseURL") as! String
    static let modelImageBaseURL = Bundle.main.object(forInfoDictionaryKey: "ModelmageURL") as! String
    
    static let baseImageURL = "https://media.ed.edmunds-media.com/"
}
