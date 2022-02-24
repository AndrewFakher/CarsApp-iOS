//
//  CarModelsCoordinator.swift
//  Cars-App
//
//  Created by Andrew on 2/24/22.
//

import Foundation
import UIKit
import Reusable
protocol CarModelsCoordinator: class {
    func pushToModelPhotos(with modelImages: [Photo])
    func popToCarListVC()
}

class CarModelsCoordinatorImplementation: Coordinator {
    unowned let navigationController: UINavigationController
    let carId: Int
    
    init(navigationController: UINavigationController, carId: Int) {
        self.navigationController = navigationController
        self.carId = carId
    }
    
    func start() {
        let carModelsViewController = CarModelsVC.instantiate()
        let carModelsViewModel = CarModelsViewModel(fetchCarModelsUseCase: FetchCarModelsUseCase(), coordinator: self, carId: carId)
        carModelsViewController.viewModel = carModelsViewModel
        
        navigationController.pushViewController(carModelsViewController, animated: true)
    }
}

extension CarModelsCoordinatorImplementation: CarModelsCoordinator {
    func pushToModelPhotos(with modelImages: [Photo]){
        let modelPhotosCoordinator = ModelPhotosCoordinatorImplementation(
            navigationController: navigationController,
            modelPhotos: modelImages
        )
        coordinate(to: modelPhotosCoordinator)
    }
    
    func popToCarListVC() {
        navigationController.popViewController(animated: true)
    }
    
}
