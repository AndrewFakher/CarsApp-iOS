//
//  CarModelsViewModel.swift
//  Cars-App
//
//  Created by Andrew on 2/20/22.
//

import Foundation
import RxSwift
import RxCocoa
class CarModelsViewModel {

    // MARK: - Private Properties
    private let fetchCarModelsUseCase: FetchCarModelsUseCase
    private let coordinator: CarModelsCoordinator
    let didChooseModelWithImages = PublishRelay<[Photo]>()
    let didTapOkButton = PublishRelay<Void>()
    private var carModelsModelSubject = PublishSubject<[CarModelWithImage]>()
    private var loadingBehavior = BehaviorRelay<Bool>(value: false)
    private var isNoModels = BehaviorRelay<Bool>(value: false)
    private let disposeBag = DisposeBag()
    
    private var currentPage = 1
    private var carId: Int
    private var totalPages = Int()
    private var hasMorePages: Bool {return currentPage <= totalPages}
    private var carModelsWithImages = [CarModelWithImage]()

    var carModelsModelObservable: Observable<[CarModelWithImage]> {
        return carModelsModelSubject
    }
    
    var isNoModelsObservable: Observable<Bool> {
        return isNoModels.asObservable()
    }
    
    var loadingBehaviorObservable: Observable<Bool> {
        return loadingBehavior.asObservable()
    }
    
    // MARK: - Initialization
    init(fetchCarModelsUseCase: FetchCarModelsUseCase, coordinator: CarModelsCoordinator, carId: Int){
        self.fetchCarModelsUseCase = fetchCarModelsUseCase
        self.coordinator = coordinator
        self.carId = carId
        
        bindOnDidChooseModel()
        bindOnDidTapOkButton()
    }
    
    // MARK: - Service Methods
    func fetchCarModelsList(){
        fetchCarModelsUseCase.getCarModels(page:  String(currentPage), car_id: carId)
            .subscribe(onSuccess: { [weak self] (response) in
                guard let self = self else {return}
                guard let responseModels = response.results else {return}
                if responseModels.count > 0 {
                    self.getModelImage(allCarModels: responseModels)
                    self.isNoModels.accept(false)
                }else{
                    self.isNoModels.accept(true)
                }
                self.totalPages = response.totalPages
            }, onFailure: { (error) in
                print(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }

    func getModelImage(allCarModels: [CarModel]){
        loadingBehavior.accept(true)
        for model in allCarModels{
            fetchCarModelsUseCase.getCarModelImage(makeName: model.makeName, name: model.name)
                .subscribe(onSuccess: { [weak self] (response) in
                    guard let self = self else {return}
                    self.loadingBehavior.accept(false)
                    guard let modelImage =  response.photos, modelImage.count != 0 else {return}
                    let modeImage = AppConfigurations.baseImageURL + modelImage[0].sources[0].link.href
                    self.carModelsWithImages.append(CarModelWithImage(makeId: model.makeId, makeName: model.makeName, niceName: model.niceName, name: model.name, image: modeImage, modelImages: modelImage))
                    self.carModelsModelSubject.onNext(self.carModelsWithImages)
                    self.currentPage += 1
                }, onFailure: { (error) in
                    self.loadingBehavior.accept(false)
                    print(error.localizedDescription)
                })
                .disposed(by: disposeBag)
        }
    }
    
    func getNextPage(indexpath: Int){
        if (indexpath == self.carModelsWithImages.count - 1) && hasMorePages{
            fetchCarModelsList()
        }
    }
    
    
    // MARK: - Binding
    private func bindOnDidChooseModel() {
        didChooseModelWithImages
            .subscribe(onNext: { [unowned self] (images) in
                self.coordinator.pushToModelPhotos(with: images)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindOnDidTapOkButton() {
        didTapOkButton
            .subscribe(onNext: { [unowned self] in
                self.coordinator.popToCarListVC()
            })
            .disposed(by: disposeBag)
    }
}
