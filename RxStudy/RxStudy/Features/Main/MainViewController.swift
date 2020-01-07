//
//  ViewController.swift
//  RxStudy
//
//  Created by Cha Cha on 30/12/2019.
//  Copyright © 2019 Cha corp. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UITabBarController {
    var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Request<KaKaoStyle<TestData>>(KakaoRouter.shopRank(size: 1000))
            .asObservable()
            .subscribe(onNext: { result in
                switch result {
                case let .success(value):
                    print(value)
                case let .failure(error):
                    error
                }
            }, onError: { error in
                
            })
        .disposed(by: disposeBag)
            
    }
}

