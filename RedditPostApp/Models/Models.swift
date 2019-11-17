//
//  Models.swift
//  RedditPostApp
//
//  Created by Nisum on 11/17/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import Foundation

// MARK: - PostModel
struct PostResponse: Codable {
    let kind: String
    let data: PostModelData
}

// MARK: - PostModelData
struct PostModelData: Codable {
    let children: [RedditPostData]
}

// MARK: - Child
struct RedditPostData: Codable {
    let kind: String
    let data: RedditPost
}

// MARK: - ChildData
struct RedditPost: Codable {
    let id, author: String
    let thumbnail: String
    let name: String
    let created: Int
    let title: String
    let numComments: Int

    enum CodingKeys: String, CodingKey {
        case id, author, thumbnail, name, created, title
        case numComments = "num_comments"
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
