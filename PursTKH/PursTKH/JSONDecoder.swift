//
//  JSONDecoder.swift
//  PursTKH
//
//  Created by Jared Hubbard on 5/26/24.
//

import Foundation

struct BusinessHoursResponse : Codable {
    var locationName : String
    var hours : [BusinessHours]
    
    enum CodingKeys: String, CodingKey {
        case locationName = "location_name"
        case hours
    }
}
