//
//  MoyaCarsDataSourceService.swift
//  Cars-App
//
//  Created by Andrew on 2/20/22.
//

import Foundation
import Moya
import RxSwift

class MoyaCarsDataSourceService: CarsDataSource {
    private let provider = MoyaProvider<CarsListAPI>(plugins:[NetworkLoggerPlugin()])
    
    func getCarsList(page:String) -> Single<CarsPage> {
        return provider.rx.request(.getCarsList(page: page)).map({
            try JSONDecoder().decode(CarsPage.self, from: $0.data)
        })
    }
}

