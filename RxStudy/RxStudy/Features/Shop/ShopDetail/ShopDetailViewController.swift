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

    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: ShopDetailViewModel = ShopDetailViewModel()
    
    private let disposeBag: DisposeBag = DisposeBag()
    private let shopDetailCell = "ShopDetailCell"
    private let shopDetailWebPage = "shopDetailWebPage"
    
    private let cellSize: CGSize = CGSize(width: UIScreen.main.bounds.width / 2 - 15, height: 90)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        bindAction()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier {
        case shopDetailWebPage:
            break
        default:
            break
        }
    }

    func bindData() {
        
        viewModel.getPresentItems()
            .bind(to: collectionView.rx.items(cellIdentifier: shopDetailCell)) { (_, model: ShopDetailPresentModel, cell: ShopDetailCell ) in
                cell.display(model)
        }
        .disposed(by: disposeBag)
    }
    
    func bindAction() {
//        collectionView.rx.itemSelected
//            .subscribe(onNext: { [weak self] indexPath in
//                self?.performSegue(withIdentifier: self?.shopDetailWebPage ?? "", sender: self?.viewModel.getDetailUrl(indexPath.row))
//            })
//            .disposed(by: disposeBag)
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
