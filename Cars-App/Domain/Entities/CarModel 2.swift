//
//  CarModel.swift
//  Cars-App
//
//  Created by Andrew on 2/21/22.
//

import Foundation

struct CarModelsPage: Codable {
    let totalNumber: Int
    let totalPages: Int
    let results: [CarModel]?
}

struct CarModel: Codable {
    let makeId: Int
    let makeName: String
    let niceName: String
    let name: String
}

struct CarModelWithImage: Codable{
    let makeId: Int
    let makeName: String
    let niceName: String
    let name: String
    let image: String
    let modelImages: [Photo]
}
