//
//  ModelImagesCollectionCell.swift
//  Cars-App
//
//  Created by Andrew on 2/22/22.
//

import UIKit
import Reusable
import Nuke
class ModelImagesCollectionCell: UICollectionViewCell, NibReusable {

    @IBOutlet weak var modelImage: UIImageView!

    var image: Photo? {
        didSet {
            guard let image = image else {return}
            Nuke.loadImage(with:  AppConfigurations.baseImageURL + image.sources[0].link.href, into: modelImage)
        }
    }
}
