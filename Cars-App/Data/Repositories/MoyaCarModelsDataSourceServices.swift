//
//  MoyaCarModelsDataSourceServices.swift
//  Cars-App
//
//  Created by Andrew on 2/21/22.
//

import Foundation
import Moya
import RxSwift

class MoyaCarModelsDataSourceServices: CarModelsDataSource {
    private let provider = MoyaProvider<CarModelAPI>(plugins:[NetworkLoggerPlugin()])
    private let imageProvider = MoyaProvider<CarModelAPI>(plugins:[NetworkLoggerPlugin()])

    func getCarModels(page:String, car_id: Int) -> Single<CarModelsPage> {
        return provider.rx.request(.getCarModels(page: page, carID: car_id)).map({
            try JSONDecoder().decode(CarModelsPage.self, from: $0.data)
        })
    }
    
    func getCarModelImage(makeName: String, name: String) -> Single<CarModelImage> {
        return imageProvider.rx.request(.getCarModelImage(makeName: makeName, name: name)).map({
            try JSONDecoder().decode(CarModelImage.self, from: $0.data)
        })
    }
}

