//
//  HomeDetails.swift
//  KrishnaVideoPlayer
//
//  Created by Krishnarjun Banoth on 02/02/20.
//  Copyright © 2020 Krishnarjun Banoth. All rights reserved.
//

import Foundation

// MARK: - HomeDetail
struct HomeDetail: Codable {
    let title: String
    let nodes: [Node]
}

// MARK: - Node
struct Node: Codable {
    let video: Video
}

// MARK: - Video
struct Video: Codable {
    let encodeURL: String
    
    enum CodingKeys: String, CodingKey {
        case encodeURL = "encodeUrl"
    }
}

typealias HomeDetails = [HomeDetail]
