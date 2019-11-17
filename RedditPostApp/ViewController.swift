//
//  ViewController.swift
//  RedditPostApp
//
//  Created by Nisum on 11/17/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        RedditAPI.shared.getToken { (result) in
            switch result {
            case .success:
                RedditAPI.shared.getPosts(limit: "10", nextPageId: "") { (result) in
                    switch result {
                    case .success(let response):
                        print(response[0])
                    case .failure(let error):
                        print(error)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }


    }


}

