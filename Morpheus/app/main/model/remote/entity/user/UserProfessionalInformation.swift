//
//  UserProfessionalInformation.swift
//  Morpheus
//
//  Created by José Ruiz on 6/1/23.
//

import Foundation

struct UserProfessionalInformation: Codable {
    var preparation: Preparation? = nil
    var wageAspiration: Int? = nil
    var category: String? = nil
    var location: String? = nil
}
