//
//  Car.swift
//  Cars-App
//
//  Created by Andrew on 2/20/22.
//

import Foundation

struct CarsPage: Codable {
    let totalNumber: Int
    let totalPages: Int
    let results: [Car]
}

struct Car: Codable {
    let id: Int
    let name: String
    let niceName: String
    let models: [Model]?
}

struct Model: Codable {
    let id: String
    let name: String
    let niceName: String
}
