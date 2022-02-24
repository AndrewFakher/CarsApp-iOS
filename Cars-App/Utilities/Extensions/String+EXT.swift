//
//  String+EXT.swift
//  Cars-App
//
//  Created by Andrew on 2/23/22.
//

import Foundation
extension String{
    func whispaceTerminate() -> String{
        return self.replacingOccurrences(of: " ", with: "")
    }
}
