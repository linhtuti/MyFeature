//
//  BaseVC.swift
//  MyF
//
//  Created by macOS on 4/9/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import UIKit

class BaseVC: UIViewController, BaseVCProtocol, BaseView {
    typealias T = BasePresenter

    var presenter: T?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.attach(self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.presenter?.detach()
    }
}


protocol BaseVCProtocol {
    associatedtype T
}
