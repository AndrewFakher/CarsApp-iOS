//
//  CarModelsViewModelTest.swift
//  Cars-AppTests
//
//  Created by Andrew on 2/24/22.
//

import Foundation
import XCTest
import RxSwift
@testable import Cars_App

class CarModelsViewModelTest: XCTestCase {

    var sut: CarModelsViewModel!
    private var fetchCarModelsUseCase: FetchCarModelsUseCase!
    private var navigationController: UINavigationController!
    private var disposeBag: DisposeBag!
    
    override func setUp() {
        disposeBag = DisposeBag()
        fetchCarModelsUseCase = FetchCarModelsUseCase()
        navigationController = UINavigationController()
        sut = CarModelsViewModel(fetchCarModelsUseCase: fetchCarModelsUseCase, coordinator: CarModelsCoordinatorImplementation(navigationController: navigationController, carId: 200009788), carId: 200009788)
        sut.fetchCarModelsList()
    }

    override func tearDown() {
        fetchCarModelsUseCase = nil
        navigationController = nil
        sut = nil
        disposeBag = nil
        super.tearDown()
    }

    func testgetListOfCarMakes(){
        let expectation = XCTestExpectation.init(description: "get car models list")
        var responseResult: [CarModelWithImage]!
        sut.carModelsModelObservable.subscribe({ (cars) in
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
