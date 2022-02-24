//
//  Indicatable+EXT.swift
//  Cars-App
//
//  Created by Andrew on 2/23/22.
//

import Foundation
import UIKit.UIViewController

//MARK: Activity Indicator Extension
fileprivate var activityIndicator = UIActivityIndicatorView(style: .large)

extension Indicatable where Self: UIViewController {
    
    func showActivityIndicator() {
        activityIndicator.center = self.view.center
        activityIndicator.color = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            activityIndicator.stopAnimating()
        }
    }
}
