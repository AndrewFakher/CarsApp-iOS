//
//  CarsListViewModel.swift
//  Cars-App
//
//  Created by Andrew on 2/20/22.
//

import Foundation
import RxSwift
import RxCocoa

class CarsListViewModel{
    
    // MARK: - Private Properties
    private let fetchCarsUseCase: FetchCarsUseCase
    private let coordinator: CarListCoordinator
    private let carsModelsModelSubject = PublishSubject<[Car]>()
    let didChooseCarWithId = PublishRelay<Int>()
    private let loadingBehavior = BehaviorRelay<Bool>(value: false)
    private let alertBehavior = BehaviorRelay<String>(value: "")
    private let disposeBag = DisposeBag()
    
    private var currentPage = 1
    private var totalPages = Int()
    private var hasMorePages: Bool {return currentPage <= totalPages}
    private var cars = [Car]()
    
    var loadingBehaviorObservable: Observable<Bool> {
        return loadingBehavior.asObservable()
    }
    
    var alertBehaviorObservable: Observable<String> {
        return alertBehavior.asObservable()
    }
    
    var carsModelsModelObservable: Observable<[Car]> {
        return carsModelsModelSubject
    }
    
    // MARK: - Initialization
    init(fetchCarsUseCase: FetchCarsUseCase, coordinator: CarListCoordinator){
        self.fetchCarsUseCase = fetchCarsUseCase
        self.coordinator = coordinator
        
        bindOnDidChooseCar()
    }
    
    
    // MARK: - Service Methods
    func fetchCarsList(){
        loadingBehavior.accept(true)
        fetchCarsUseCase.getCarsList(page: String(currentPage))
            .subscribe(onSuccess: {[weak self] (response) in
                guard let self = self else {return}
                self.loadingBehavior.accept(false)
                self.cars.append(contentsOf: response.results)
                self.carsModelsModelSubject.onNext(self.cars.sorted{$0.name.lowercased() < $1.name.lowercased()})
                self.totalPages = response.totalPages
                self.currentPage += 1
            }, onFailure: { (error) in
                self.loadingBehavior.accept(false)
            })
            .disposed(by: disposeBag)
    }
    
    func getNextPage(indexpath: Int){
        if (indexpath == self.cars.count - 1) && hasMorePages{
            fetchCarsList()
        }
    }
    
    // MARK: - Binding
    private func bindOnDidChooseCar() {
        didChooseCarWithId
            .subscribe(onNext: { [unowned self] (id) in
                self.coordinator.pushToCarModels(with: id)
            })
            .disposed(by: disposeBag)
    }
}
