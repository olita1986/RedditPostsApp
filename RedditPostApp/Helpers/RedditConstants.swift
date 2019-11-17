//
//  RedditConstants.swift
//  RedditPostApp
//
//  Created by Nisum on 11/17/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import Foundation

enum RedditContansts {
    enum API {
        static var authURL = "https://www.reddit.com/api/v1/access_token?grant_type=https://oauth.reddit.com/grants/installed_client&device_id=12345678901234567890"
        static var topPostsURL = "https://oauth.reddit.com/top?limit=%@&after=%@"
        enum Login {
            static var basicAuth = "Basic XzB1UjhNckJqT2lnaGc6elU2OE9UcHN0M05aZlVfSFRQOGNkcWQtTGdV"
        }
    }
}
