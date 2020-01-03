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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.updatePageCount(0)
    }

    func bind() {
        viewModel.items
            .bind(to: tableView.rx.items(cellIdentifier: "ShopTableViewCell")) { (index: Int, model: ShopModel, cell: ShopTableViewCell) in
                cell.display(model)
        }.disposed(by: disposeBag)
    }
 
}

extension ShopViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //todo scroll item udpate event
    }
    
}
