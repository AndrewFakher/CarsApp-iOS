//
//  ModelPhotosVC.swift
//  Cars-App
//
//  Created by Andrew on 2/22/22.
//

import UIKit
import Reusable
import RxSwift
import RxCocoa
class ModelPhotosVC: UIViewController, UICollectionViewDelegateFlowLayout, StoryboardBased {

    // MARK: - Outlets
    @IBOutlet weak var modelImagesCollection: UICollectionView!
    
    // MARK: - Properties
    var viewModel: ModelPhotosViewModel!
    private let disposeBag = DisposeBag()
    
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupModelPhotosCollection()
        bindToPhotosModel()
        viewModel.fetchModelPhotos()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        modelImagesCollection.scrollToItem(at: IndexPath(row: 0, section: 0) , at: .centeredHorizontally, animated: false)
    }
    
    // MARK: - Setup CollectionView
    func setupModelPhotosCollection(){
        modelImagesCollection.register(cellType: ModelImagesCollectionCell.self)
        modelImagesCollection.rx.setDelegate(self).disposed(by:disposeBag)
    }
    
    // MARK: - Binding
    func bindToPhotosModel() {
        self.viewModel.modelPhotosSubjectlObservable
            .bind(to: self.modelImagesCollection
            .rx
            .items(cellIdentifier: ModelImagesCollectionCell.reuseIdentifier, cellType: ModelImagesCollectionCell.self)) { _, image, cell in
                cell.image = image
            }
            .disposed(by: disposeBag)
    }
}

extension ModelPhotosVC{
    // MARK: - Collectionview DelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Dimensions.screenWidth, height: collectionView.frame.height)
    }
}
