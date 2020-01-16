//
//  ShopDetailViewController.swift
//  RxStudy
//
//  Created by andrew on 2020/01/08.
//  Copyright © 2020 Cha corp. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ShopDetailViewController: UIViewController {
    
    @IBOutlet weak var headerInfoView: UIView!
    @IBOutlet weak var verticalCollectionHeaderTabView: UIView!
    @IBOutlet weak var verticalCollectionView: UICollectionView!
    
    var viewModel: ShopDetailViewModel = ShopDetailViewModel()
    
    private let disposeBag: DisposeBag = DisposeBag()
    private let shopDetailCell = "ShopDetailCell"
    private let shopDetailWebPage = "shopDetailWebPage"
    
    private let cellSize: CGSize = CGSize(width: UIScreen.main.bounds.width / 2 - 15, height: 90)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        bindData()
        bindAction()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier {
        case shopDetailWebPage:
//            guard let shopDetailWebVC = segue.destination as? ShopDetailWebViewController,
//                let url = sender as? URL
//                else { return }
            break
        default:
            break
        }
    }
    
    //MARK: - UI
    func initUI() {
        
    }
    
    //MARK: - Bind
    func bindData() {
        
        viewModel.getPresentItems()
            .bind(to: verticalCollectionView.rx.items(cellIdentifier: shopDetailCell)) { (index: Int, model: ShopDetailPresentModel, cell: ShopDetailCell ) in
                cell.display(model)
        }
        .disposed(by: disposeBag)
    }
    
    func bindAction() {
        
        verticalCollectionView.rx.itemSelected
            .compactMap { [weak self] indexPath in
                self?.viewModel.getDetailUrl(indexPath.row)
        }
            .map { URL(string: $0.linkUrl) }
            .subscribe { [weak self] url in
                self?.performSegue(withIdentifier: self?.shopDetailWebPage ?? "", sender: url)}
            .disposed(by: disposeBag)
    }
    
}

extension ShopDetailViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.pageCountUpdate(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }
    
}
