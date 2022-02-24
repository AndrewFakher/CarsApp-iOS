//
//  CarModelsDataSource.swift
//  Cars-App
//
//  Created by Andrew on 2/21/22.
//

import Foundation
import RxSwift

protocol CarModelsDataSource {
    func getCarModels(page: String, car_id: Int)->Single<CarModelsPage>
    func getCarModelImage(makeName: String, name: String)->Single<CarModelImage>
}
