//
//  Experience.swift
//  Morpheus
//
//  Created by José Ruiz on 6/1/23.
//

import Foundation

struct Experience: Codable {
    var years: Int = 0
    var jobs: [Job]? = nil
    var mandatory: Bool = false
}
