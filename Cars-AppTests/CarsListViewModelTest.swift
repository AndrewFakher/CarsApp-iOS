//
//  CarsListViewModelTest.swift
//  Cars-AppTests
//
//  Created by Andrew on 2/23/22.
//

import Foundation
import XCTest
import RxSwift
@testable import Cars_App

class CarsListViewModelTest: XCTestCase {

    var sut: CarsListViewModel!
    private var fetchCarsUseCase: FetchCarsUseCase!
    private var navigationController: UINavigationController!
    private var disposeBag: DisposeBag!

    override func setUp() {
        disposeBag = DisposeBag()
        fetchCarsUseCase = FetchCarsUseCase()
        navigationController = UINavigationController()
        sut = CarsListViewModel(fetchCarsUseCase: fetchCarsUseCase, coordinator: CarListCoordinatorImplementation(navigationController: navigationController))
        sut.fetchCarsList()
    }

    override func tearDown() {
        fetchCarsUseCase = nil
        navigationController = nil
        sut = nil
        disposeBag = nil
        super.tearDown()
    }

    func testgetListOfCarMakes(){
        let expectation = XCTestExpectation.init(description: "get cars list")
        var responseResult: [Car]!
        sut.carsModelsModelObservable.subscribe({ (cars) in
            switch cars{
            case .next(let responseObj):
                responseResult = responseObj
                expectation.fulfill()
            case .error(_):
                expectation.fulfill()
            case .completed:
                print("Completed")
            }
        }).disposed(by: disposeBag)
        wait(for: [expectation], timeout: 10.0)
        XCTAssert(responseResult.count > 0)
    }
}
