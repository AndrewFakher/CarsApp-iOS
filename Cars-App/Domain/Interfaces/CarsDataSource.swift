//
//  CarsDataSource.swift
//  Cars-App
//
//  Created by Andrew on 2/20/22.
//

import Foundation
import RxSwift

protocol CarsDataSource {
    func getCarsList(page: String)->Single<CarsPage>
}
