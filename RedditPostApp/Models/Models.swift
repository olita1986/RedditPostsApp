//
//  Models.swift
//  RedditPostApp
//
//  Created by Nisum on 11/17/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import Foundation

// MARK: - PostResponse
struct PostResponse: Codable {
    let kind: String
    let data: PostResponseData
}

// MARK: - PostResponseData
struct PostResponseData: Codable {
    let children: [Child]
    let after: String
}

// MARK: - Child
struct Child: Codable {
    let kind: String
    let data: RedditPost
}

// MARK: - ChildData
struct RedditPost: Codable {
    let thumbnail: String
    let created: Int
    let id: String
    let author: String
    let numComments: Int
    let url: String
    let title: String

    enum CodingKeys: String, CodingKey {
        case title
        case thumbnail
        case created
        case id
        case author
        case numComments = "num_comments"
        case url
    }
}

// MARK: - TokenResponse
struct TokenResponse: Codable {
    let accessToken, tokenType, deviceID: String
    let expiresIn: Int
    let scope: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case deviceID = "device_id"
        case expiresIn = "expires_in"
        case scope
    }
}
