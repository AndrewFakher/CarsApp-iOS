//
//  ViewProtocols.swift
//  Cars-App
//
//  Created by Andrew on 2/23/22.
//

import Foundation
protocol Indicatable: class {
    func showActivityIndicator()
    func hideActivityIndicator()
}

protocol Alertable: class {
    func showAlert(msg:String, completion : @escaping ()->())
}

