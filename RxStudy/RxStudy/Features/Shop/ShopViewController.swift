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
//        mapTest()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier {
        case shopDetailPage:
            guard let shopDetailVC = segue.destination as? ShopDetailViewController,
                let shopPresentModel = sender as? ShopPresentModel
                else { return }
            shopDetailVC.viewModel.setRegisterNum(shopPresentModel.no)
            
        default:
            break
        }
        
    }
    
    func mapTest() {
        
        //MARK: - map
        Observable.of(1,2,3)
            .map { $0 * 2 }
            .subscribe(onNext: {
                print($0)
            }).disposed(by: disposeBag)
        
        
        //MARK: - flatMap
        struct Student {
            var name: BehaviorSubject<String>
        }
        
        let flatMapStudent: PublishSubject<Student> = .init()
        
        flatMapStudent
            .flatMap { student -> Observable<String> in
                student.name
        }.subscribe(onNext: { name in
            print(name)
        }).disposed(by: disposeBag)
        
        
        let seungyun = Student(name: BehaviorSubject(value: "seungyun"))
        flatMapStudent.onNext(seungyun)
        
        let andrew = Student(name: BehaviorSubject(value: "andrew"))
        flatMapStudent.onNext(andrew)
        
        seungyun.name.onNext("KIM SEUNG YUN")
        
        //MARK: - flatMapLatest
        
        let flatMapLatestStudent: PublishSubject<Student> = .init()
        flatMapLatestStudent
            .flatMapLatest { student -> Observable<String> in
                student.name
        }.subscribe(onNext: { name in
            print(name)
        }).disposed(by: disposeBag)
        
        
        let maria = Student(name: BehaviorSubject(value: "maria"))
        flatMapLatestStudent.onNext(maria)
        
        let carmen = Student(name: BehaviorSubject(value: "carmen"))
        flatMapLatestStudent.onNext(carmen)
        
        maria.name.onNext("IS NOT CALLING")
        
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
