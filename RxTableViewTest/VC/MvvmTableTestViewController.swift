
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
    var testViewModel: TestViewModel!
    
    fileprivate let SHOW_DISAPPEAR_VIEW = "show_disappear_view"
    override func viewDidLoad() {
        super.viewDidLoad()
        testViewModel = TestViewModel.init()
        bind()
        moreBtn.sendActions(for: .touchUpInside)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case SHOW_DISAPPEAR_VIEW:
            if let disappearTestVC = segue.destination as? DisappearTestVC {
                disappearTestVC.regNo = sender as? Int
            }
        default:
            break
        }
        
        super.prepare(for: segue, sender: sender)
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
        
        moreBtn.rx.tap
            .subscribe { event in
                self.viewModel.pageCount.accept(self.viewModel.pageCount.value + 1)
        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .bind { [weak self] indexPath in
                guard let `self` = self else { return }
                let regNo = self.viewModel.items.value[indexPath.row].regNo
                self.performSegue(withIdentifier: self.SHOW_DISAPPEAR_VIEW, sender: regNo)
        }.disposed(by: disposeBag)
        
    }
    
    //    func bind() {
    //
    //        testViewModel.setItems
    //            .observeOn(MainScheduler.instance)
    //            .bind(to: tableView.rx.items(cellIdentifier: "EndTakeCell")) { (index: Int, model: EndTakeModel, cell: EndTakeCell) in
    //                cell.display(model)
    //        }.disposed(by: disposeBag)
    //
    //    }
    
    
}

