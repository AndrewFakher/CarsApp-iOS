//
//  CarsListAPI.swift
//  Cars-App
//
//  Created by Andrew on 2/20/22.
//

import Foundation
import Moya

enum CarsListAPI{
    case getCarsList(page: String)
}

extension CarsListAPI: TargetType{
    
    var baseURL: URL {
        URL(string: "\(AppConfigurations.apiBaseURL)")!
    }
    
    var path: String {
        switch self {
        case .getCarsList:
            return "/makes"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCarsList:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getCarsList(let page):
            return .requestParameters(parameters: [
                "api_key":AppConfigurations.apiKey,
                "pageNum": page,
                "pageSize": 20
                ]
                ,encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        nil
    }
}
