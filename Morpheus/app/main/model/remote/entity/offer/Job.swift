//
//  Job.swift
//  Morpheus
//
//  Created by José Ruiz on 6/1/23.
//

import Foundation

struct Job: Codable {
    var enterprise: String? = nil
    var role: String? = nil
    var activities: [Activity]? = nil
    var period: Period? = nil
}
