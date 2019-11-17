//
//  RedditAPI.swift
//  RedditPostApp
//
//  Created by Nisum on 11/17/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import Foundation

class RedditAPI: RedditAPIService {
    let client: Client
    var token: String = ""

    static let shared = RedditAPI()

    init(client: Client = UrlSessionClient()) {
        self.client = client
    }

    func getToken(completion: @escaping (Result<Void, RedditError>) -> Void) {
        let formattedString = RedditContansts.API.authURL
        let url = URL(string: formattedString)!
        let basicAuth = RedditContansts.API.Login.basicAuth
        let header: (header: HeaderType, value: String) = (header: .authorization, value: basicAuth)
        client.genericRequest(
            withType: TokenResponse.self,
            url: url,
            method: .post,
            headers: [header],
            completion: { [weak self] result in
                switch result {
                case .success(let tokenResponse):
                    self?.token = tokenResponse.accessToken
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        )
    }

    func getPosts(limit: String, nextPageId: String, completion: @escaping (Result<[RedditPost], RedditError>) -> Void) {
        let formattedString = String(format:RedditContansts.API.topPostsURL, limit, nextPageId)
        let url = URL(string: formattedString)!
        let header: (header: HeaderType, value: String) = (header: .authorization, value: "Bearer \(token)")

        client.genericRequest(withType: PostResponse.self, url: url, method: .get, headers: [header], completion: { result in

            switch result {
            case .success(let postResponse):
                let redditPosts = postResponse.data.children.compactMap{ $0.data }
                completion(.success(redditPosts))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

}

protocol RedditAPIService {
    func getToken(completion: @escaping (Result<Void, RedditError>) -> Void)
}
