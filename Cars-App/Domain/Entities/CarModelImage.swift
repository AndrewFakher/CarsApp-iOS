//
//  CarModelImage.swift
//  Cars-App
//
//  Created by Andrew on 2/22/22.
//

import Foundation
struct CarModelImage: Codable {
    let photos: [Photo]?
}

struct Photo: Codable {
    let sources: [Source]
}

struct Source: Codable {
    let link: Link
}

struct Link: Codable {
    let href: String
}
