//
//  WelcomeInteractor.swift
//  RedditPostApp
//
//  Created by Nisum on 11/17/19.
//  Copyright (c) 2019 Orlando Arzola. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol WelcomeBusinessLogic {
    func login()
}

protocol WelcomeDataStore {

}

class WelcomeInteractor: WelcomeBusinessLogic, WelcomeDataStore {
    var presenter: WelcomePresentationLogic?
    var worker = WelcomeWorker()

    func login() {
        presenter?.presentLoading()
        worker.login { [weak self] result in
            self?.presenter?.dismissLoading()
            switch result {
            case .success:
                self?.presenter?.presentPosts()
            case .failure(let error):
                print(error.localizedDescription)
                self?.presenter?.presentError()
            }
        }
    }
}
