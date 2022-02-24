//
//  CarModelAPI.swift
//  Cars-App
//
//  Created by Andrew on 2/21/22.
//

import Foundation
import Moya

enum CarModelAPI{
    case getCarModels(page: String, carID: Int)
    case getCarModelImage(makeName: String, name: String)
}

extension CarModelAPI: TargetType{
    
    var baseURL: URL {
        switch self {
        case .getCarModels:
            return URL(string: "\(AppConfigurations.apiBaseURL)")!

        case .getCarModelImage:
            return URL(string: "\(AppConfigurations.modelImageBaseURL)")!
        }
    }
    
    var path: String {
        switch self {
        case .getCarModels:
            return "/models"
        case .getCarModelImage(let makeName, let name):
            return "/\(makeName)/\(name)/2022/photos".whispaceTerminate()
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCarModels, .getCarModelImage:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getCarModels(let page, let carID):
            return .requestParameters(parameters: [
                "api_key":AppConfigurations.apiKey,
                "pageNum": page,
                "pageSize": 20,
                "makeId":carID,
                "modelYears.year": 2022,
                "publicationStates":"NEW"
                ]
                ,encoding: URLEncoding.queryString)
            
        case .getCarModelImage:
            return .requestParameters(parameters: [
                "api_key":AppConfigurations.apiKey
                ]
                ,encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        nil
    }
}
