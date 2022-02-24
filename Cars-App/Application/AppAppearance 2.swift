//
//  AppAppearance.swift
//  Cars-App
//
//  Created by Andrew on 2/20/22.
//

import Foundation
import  UIKit
final class AppAppearance {
    static func setupAppearance(){
        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
}
