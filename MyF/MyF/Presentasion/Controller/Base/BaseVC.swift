//
//  BaseVC.swift
//  MyF
//
//  Created by macOS on 4/9/18.
//  Copyright © 2018 macOS. All rights reserved.
//

import UIKit

class BaseVC<T: Presenter>: UIViewController, BaseView{
    var presenter: T?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    init(presenter: T) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.attach(self)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter?.detach()
    }
}


extension BaseVC {
    func showAlertMessage(title: String?, message: String?, cancelBlock:((Bool)->Void)? = nil) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: { _ in
            cancelBlock?(true)
        }))

        self.present(alert, animated: true, completion: nil)
    }

}
