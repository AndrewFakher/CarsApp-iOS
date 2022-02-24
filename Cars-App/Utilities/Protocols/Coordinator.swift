//
//  Coordinator.swift
//  Cars-App
//
//  Created by Andrew on 2/24/22.
//

import Foundation

protocol Coordinator: class {
    func start()
    func coordinate(to coordinator: Coordinator)
}

extension Coordinator {
    func coordinate(to coordinator: Coordinator) {
        coordinator.start()
    }
}
