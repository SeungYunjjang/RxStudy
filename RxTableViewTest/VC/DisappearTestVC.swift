
//
//  DisappearTestVC.swift
//  RxTableViewTest
//
//  Created by andrew on 2019/12/23.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit
import RxSwift

//param : take_reg_no

class DisappearTestVC: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    
    var regNo: Int?
    var viewModel = EndTakeDetailViewModel()
    var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.presentationController?.delegate = self
        bind()
    }
    
    func bind() {
        
        viewModel.regNo
            .subscribe(onNext: { (num) in
                self.viewModel.update()?.disposed(by: self.disposeBag)
            }).disposed(by: disposeBag)
        
        viewModel.items
            .subscribe(onNext: { [weak self] model in
                guard let `self` = self else { return }
                self.mainImageView.image = model.mainImage
                self.titleLabel.text = model.title
            }).disposed(by: disposeBag)
        
        viewModel.regNo.accept(regNo ?? 0)
        print(regNo ?? 0)
    }
    
}


extension DisappearTestVC: UIAdaptivePresentationControllerDelegate {
    
    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
        print("presentationControllerDidAttemptToDismiss")
        let alert = UIAlertController(title: "설정", message: "", preferredStyle: .alert)
        let okaction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        
        let cancelaction = UIAlertAction(title: "cancel", style: .default) { (action) in
            
        }
        
        alert.addAction(okaction)
        alert.addAction(cancelaction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        print("presentationControllerShouldDismiss")
        return false
    }
    
    func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        print("presentationControllerWillDismiss")
    }
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        print("presentationControllerDidDismiss")
    }
    
}
