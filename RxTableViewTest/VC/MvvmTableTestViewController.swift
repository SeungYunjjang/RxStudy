
//
//  MvvmTableTestViewController.swift
//  RxTableViewTest
//
//  Created by andrew on 2019/12/11.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// URL = http://dev1.exs-mobile.com:23080/app/take/end_take
// Param = page : Int
// Response data / list


class MvvmTableTestViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var moreBtn: UIButton!
    
    var disposeBag: DisposeBag = DisposeBag()
    var viewModel = EndTakeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        disposeBag = DisposeBag()
    }
    
    func bind() {
        
        viewModel.update()?.disposed(by: disposeBag)
        
        viewModel.items
            .bind(to: tableView.rx.items(cellIdentifier: "EndTakeCell")) { (index: Int, model: EndTakeModel, cell: EndTakeCell) in
                cell.display(model)
        }.disposed(by: disposeBag)
        
        viewModel.pageCount
            .bind { (num) in
                self.viewModel.update()?.disposed(by: self.disposeBag)
        }.disposed(by: disposeBag)
        
        moreBtn.rx.tap.subscribe { (event) in
            self.viewModel.pageCount.accept(self.viewModel.pageCount.value + 1)
        }
        
    }
    
    
}







