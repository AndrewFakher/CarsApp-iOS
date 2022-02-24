//
//  CarModelsTableViewCell.swift
//  Cars-App
//
//  Created by Andrew on 2/21/22.
//

import UIKit
import Reusable
import Nuke
class CarModelsTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var modelImage: UIImageView!
    @IBOutlet weak var modelName: UILabel!
    
    var model: CarModelWithImage? {
        didSet {
            modelName.text = model?.name ?? ""
            Nuke.loadImage(with: model?.image, into: modelImage)
        }
    }
}
