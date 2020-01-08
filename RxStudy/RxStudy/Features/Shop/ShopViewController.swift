//
//  ShopViewController.swift
//  RxStudy
//
//  Created by andrew on 2020/01/02.
//  Copyright © 2020 Cha corp. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ShopViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = ShopViewModel()
    private let disposeBag = DisposeBag()
    private let shopTableViewCell = "ShopTableViewCell"
    private let shopDetailPage = "shopDetailPage"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        bindAction()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
            
        switch segue.identifier {
        case shopDetailPage:
            guard let shopDetailVC = segue.destination as? ShopDetailViewController,
                let shopPresentModel = sender as? ShopPresentModel
            else { return }
            shopDetailVC.viewModel = ShopDetailViewModel.init(shopPresentModel)
            
        default:
            break
        }
        
    }
    
    func bindData() {
        
        viewModel.getPresentItems()
            .bind(to: tableView.rx.items(cellIdentifier: shopTableViewCell)) { (index: Int, model: ShopPresentModel, cell: ShopTableViewCell) in
                cell.display(model)
        }.disposed(by: disposeBag)
        
    }
    
    func bindAction() {
        
        tableView.rx.itemSelected
            .compactMap { indexPath -> ShopPresentModel in
                self.viewModel.getDetailPresentModel(indexPath.row)
        }.subscribe { self.performSegue(withIdentifier: self.shopDetailPage, sender: $0.element) }
        .disposed(by: disposeBag)
        
    }
    
    
}

extension ShopViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.pageCountUpdate(indexPath.row)
    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        viewModel.scrollOnTop()
    }
    
}
