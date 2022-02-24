//
//  CarListCoordinator.swift
//  Cars-App
//
//  Created by Andrew on 2/24/22.
//

import Foundation
import UIKit
import Reusable

protocol CarListCoordinator: class {
    func pushToCarModels(with carId: Int)
}

class CarListCoordinatorImplementation: Coordinator {
    unowned let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let carListViewController = CarsListVC.instantiate()
        let carListViewModel = CarsListViewModel(fetchCarsUseCase: FetchCarsUseCase(),
                                                 coordinator: self)
        carListViewController.viewModel = carListViewModel
        
        navigationController.pushViewController(carListViewController, animated: true)
    }
}

extension CarListCoordinatorImplementation: CarListCoordinator {
    func pushToCarModels(with carId: Int) {
        let carModelsCoordinator = CarModelsCoordinatorImplementation(
            navigationController: navigationController,
            carId: carId
        )
        coordinate(to: carModelsCoordinator)
    }
}
