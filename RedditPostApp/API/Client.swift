//
//  Client.swift
//  RedditPostApp
//
//  Created by Nisum on 11/17/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import Foundation

protocol Client {
    func genericRequest<T: Decodable>(withType type: T.Type, url: URL, method: HTTPMethod, headers: [(header: HeaderType, value: String)], completion: @escaping ((Result<T, RedditError>) -> Void))
}

class UrlSessionClient: Client {
    func genericRequest<T>(withType type: T.Type, url: URL, method: HTTPMethod, headers: [(header: HeaderType, value: String)], completion: @escaping ((Result<T, RedditError>) -> Void)) where T : Decodable {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        for header in headers {
            urlRequest.addValue(header.value, forHTTPHeaderField: header.header.rawValue)
        }
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                completion(.failure(.generalError))
                return
            }

            guard let data = data else {
                completion(.failure(.generalError))
                return
            }

            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedObject))
                }
            } catch let error {
                print(error.localizedDescription)
                completion(.failure(.generalError))
            }
        }.resume()
    }
}

enum Result<T, U: Error> {
    case success(T)
    case failure(U)
}

enum RedditError: Error {
    case generalError
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum HeaderType: String {
    case authorization = "Authorization"
}
