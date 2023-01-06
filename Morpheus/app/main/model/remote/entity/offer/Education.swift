//
//  Education.swift
//  Morpheus
//
//  Created by José Ruiz on 6/1/23.
//

import Foundation

struct Education: Codable {
    var area: String? = nil
    var degree: String? = nil
    var level: String? = nil
    var specialization: String? = nil
    var certifications: [Certification]? = nil
    var mandatory: Bool = false
}
