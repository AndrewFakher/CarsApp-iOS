//
//  FetchCarsUseCase.swift
//  Cars-App
//
//  Created by Andrew on 2/20/22.
//

import Foundation
import RxSwift
protocol FetchCarsUseCaseInterface{
    func getCarsList(page: String)->Single<CarsPage>
}

class FetchCarsUseCase: FetchCarsUseCaseInterface {
    private let dataSource: CarsDataSource
    
    init(){
        dataSource = MoyaCarsDataSourceService()
    }
    
    func getCarsList(page: String)->Single<CarsPage>{
        return dataSource.getCarsList(page: page)
    }
}
