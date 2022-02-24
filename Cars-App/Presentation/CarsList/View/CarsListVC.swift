//
//  CarsListVC.swift
//  Cars-App
//
//  Created by Andrew on 2/20/22.
//

import UIKit
import RxSwift
import RxCocoa
import Reusable
class CarsListVC: UIViewController, StoryboardBased,Indicatable {
    
    // MARK: - Outlets
    @IBOutlet weak var carsListTableView: UITableView!
    
    // MARK: - Properties
    var viewModel: CarsListViewModel!
    private let disposeBag = DisposeBag()


    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchCarsList()
        bindLoadingState()
        bindCarsList()
        bindCarSelection()
        bindDisplayCell()
    }
    
    // MARK: - Bindings
    func bindLoadingState() {
        viewModel.loadingBehaviorObservable.subscribe(onNext: { [weak self](isLoading) in
            if isLoading {self?.showActivityIndicator()}
            else {self?.hideActivityIndicator()}
        }).disposed(by: disposeBag)
    }
    
    func bindCarsList() {
        carsListTableView.accessibilityIdentifier = Constants.carListAccessibilityIdentifier
        self.viewModel.carsModelsModelObservable
            .bind(to: self.carsListTableView
            .rx
            .items(cellIdentifier: Constants.carListIdentifier)) { _, car, cell in
                cell.textLabel?.text = car.name
                cell.accessoryType = .disclosureIndicator
            }
            .disposed(by: disposeBag)
    }
    
    func bindCarSelection() {
        carsListTableView.rx.modelSelected(Car.self)
            .compactMap { $0.id }
            .bind(to: viewModel.didChooseCarWithId)
            .disposed(by: disposeBag)
    }
    
    func bindDisplayCell(){
        carsListTableView.rx
            .willDisplayCell
            .subscribe(onNext: { [weak self] cell, indexPath in
                self?.viewModel.getNextPage(indexpath: indexPath.row)
            })
            .disposed(by: disposeBag)
    }
}
