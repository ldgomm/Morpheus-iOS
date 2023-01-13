//
//  UserSystemStatusInformation.swift
//  Morpheus
//
//  Created by José Ruiz on 6/1/23.
//

import Foundation

struct UserSystemStatusInformation: Codable {
    var isValidated: Bool = false
    var isActive: Bool = true
    var isSuspended: Bool = false
    var isBlocked: Bool = false
}
