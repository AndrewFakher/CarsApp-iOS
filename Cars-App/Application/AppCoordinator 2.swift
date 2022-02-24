//
//  AppCoordinator.swift
//  Cars-App
//
//  Created by Andrew on 2/24/22.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let carListCoordinator = CarListCoordinatorImplementation(navigationController: navigationController)
        coordinate(to: carListCoordinator)
    }
}
