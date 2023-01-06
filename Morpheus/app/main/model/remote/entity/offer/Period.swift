//
//  Period.swift
//  Morpheus
//
//  Created by José Ruiz on 6/1/23.
//

import Foundation

struct Period: Codable {
    var from: Int64? = Int64(Date().timeIntervalSince1970)
    var to: Int64? = Int64(Date().timeIntervalSince1970)
}
