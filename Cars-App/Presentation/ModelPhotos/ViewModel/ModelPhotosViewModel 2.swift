//
//  ModelPhotosViewModel.swift
//  Cars-App
//
//  Created by Andrew on 2/23/22.
//

import Foundation
import RxSwift
import RxCocoa
class ModelPhotosViewModel {
    
    // MARK: - Private Properties
    private let coordinator: ModelPhotosCoordinator
    private var modelPhotosSubject = PublishSubject<[Photo]>()
    private let disposeBag = DisposeBag()
    var modelPhotos = [Photo]()
    
    // MARK: - Initialization
    init(coordinator: ModelPhotosCoordinator, modelPhotos: [Photo]){
        self.coordinator = coordinator
        self.modelPhotos = modelPhotos
    }
    
    var modelPhotosSubjectlObservable: Observable<[Photo]> {
        return modelPhotosSubject
    }
    
    // MARK: - Service Method
    func fetchModelPhotos(){
        modelPhotosSubject.onNext(modelPhotos)
    }
}
