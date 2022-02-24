//
//  ModelPhotosCoordinator.swift
//  Cars-App
//
//  Created by Andrew on 2/24/22.
//

import Foundation
import UIKit
import Reusable
protocol ModelPhotosCoordinator: class {}

class ModelPhotosCoordinatorImplementation: Coordinator {
    unowned let navigationController: UINavigationController
    let modelPhotos: [Photo]
    
    init(navigationController: UINavigationController, modelPhotos: [Photo]) {
        self.navigationController = navigationController
        self.modelPhotos = modelPhotos
    }
    
    func start() {
        let modelPhotosViewController = ModelPhotosVC.instantiate()
        let modelPhotosViewModel = ModelPhotosViewModel(
            coordinator: self,
            modelPhotos: modelPhotos
        )
        modelPhotosViewController.viewModel = modelPhotosViewModel
        
        navigationController.pushViewController(modelPhotosViewController, animated: true)
    }
}

extension ModelPhotosCoordinatorImplementation: ModelPhotosCoordinator {}
