//
//  FetchCarModelsUseCase.swift
//  Cars-App
//
//  Created by Andrew on 2/21/22.
//

import Foundation
import RxSwift

protocol FetchCarModelsUseCaseInterface{
    func getCarModels(page: String, car_id: Int)->Single<CarModelsPage>
    func getCarModelImage(makeName: String, name: String) -> Single<CarModelImage>
}

class FetchCarModelsUseCase: FetchCarModelsUseCaseInterface {
    private let dataSource: CarModelsDataSource
    
    init(){
        dataSource = MoyaCarModelsDataSourceServices()
    }
    
    func getCarModels(page: String, car_id: Int)->Single<CarModelsPage>{
        return dataSource.getCarModels(page: page, car_id: car_id)
    }
    
    func getCarModelImage(makeName: String, name: String) -> Single<CarModelImage> {
        return dataSource.getCarModelImage(makeName: makeName, name: name)
    }
}
