//
//  YoutubeResponse.swift
//  NetflixClone
//
//  Created by Eslam Ali  on 05/04/2022.
//

import Foundation

struct YoutubeResponse : Codable {
    let items : [VideoElement]
}

struct VideoElement : Codable {
    let id : IdVideoElement
}

struct IdVideoElement: Codable {
    let kind : String?
    let videoId : String?
}


