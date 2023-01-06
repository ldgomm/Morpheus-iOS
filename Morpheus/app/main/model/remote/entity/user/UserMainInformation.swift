//
//  UserMainInformation.swift
//  Morpheus
//
//  Created by José Ruiz on 6/1/23.
//

import Foundation

struct UserMainInformation: Codable {
    var prefix: String? = nil
    var suffix: String? = nil
    var ci: String? = nil
    var ruc: String? = nil
    var about: String? = nil
    var birthday: Int64? = nil
}
