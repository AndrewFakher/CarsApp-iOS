//
//  Alertable+EXT.swift
//  Cars-App
//
//  Created by Andrew on 2/23/22.
//

import Foundation
import UIKit.UIViewController
//MARK: AlertView Extension

extension Alertable where Self: UIViewController {
    func showAlert(msg: String, completion:@escaping ()->()){
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler:
            { (action: UIAlertAction!) in
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                    completion()
                }
            })
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
