//
//  CarModelsVC.swift
//  Cars-App
//
//  Created by Andrew on 2/20/22.
//

import UIKit
import Reusable
import RxSwift
import RxCocoa
class CarModelsVC: UIViewController, StoryboardBased, Indicatable, Alertable {
    
    // MARK: - Outlets
    @IBOutlet weak var carModelsTableView: UITableView!
    
    // MARK: - Properties
    var viewModel: CarModelsViewModel!
    private let disposeBag = DisposeBag()
    var model_id = Int()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCarModelTableView()
        bindLoadingState()
        bindModelsAvilability()
        bindToCarModelsList()
        bindCarModelSelection()
        bindDisplayCell()
        viewModel.fetchCarModelsList()
    }
    
    // MARK: - Setup TableView
    func setupCarModelTableView() {
        carModelsTableView.register(cellType: CarModelsTableViewCell.self)
    }
    
    // MARK: - Bindings
    func bindLoadingState() {
        viewModel.loadingBehaviorObservable.subscribe(onNext: { [weak self](isLoading) in
            if isLoading {self?.showActivityIndicator()}
            else {self?.hideActivityIndicator()}
        }).disposed(by: disposeBag)
    }
    
    func bindModelsAvilability() {
        viewModel.isNoModelsObservable.subscribe(onNext: { [weak self](isModelsAvailable) in
            if isModelsAvailable {
                self?.showAlert(msg: "No models avilable"){
                    self?.viewModel.didTapOkButton.accept(())
            }}
        }).disposed(by: disposeBag)
    }
    
    func bindToCarModelsList() {
        self.viewModel.carModelsModelObservable
            .bind(to: self.carModelsTableView
            .rx
            .items(cellIdentifier: CarModelsTableViewCell.reuseIdentifier, cellType: CarModelsTableViewCell.self)) { _, model, cell in
                cell.model = model
            }
            .disposed(by: disposeBag)
    }

    func bindCarModelSelection() {
        carModelsTableView.rx.modelSelected(CarModelWithImage.self)
            .compactMap { $0.modelImages }
            .bind(to: viewModel.didChooseModelWithImages)
            .disposed(by: disposeBag)
    }
    
    func bindDisplayCell(){
        carModelsTableView.rx
            .willDisplayCell
            .subscribe(onNext: { [weak self] cell, indexPath in
                self?.viewModel.getNextPage(indexpath: indexPath.row)
            })
            .disposed(by: disposeBag)
    }
}
