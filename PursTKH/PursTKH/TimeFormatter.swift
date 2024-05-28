//
//  TimeFormatter.swift
//  PursTKH
//
//  Created by Jared Hubbard on 5/28/24.
//

import Foundation

func militaryTo12Converter(_ time: String) -> String {
    var correctedTime = time
    if time == "24:00:00" {
        correctedTime = "00:00:00"
    } else {
        correctedTime = time
    }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm:ss"
    if let date = dateFormatter.date(from: correctedTime) {
        dateFormatter.dateFormat = "h a"
        return dateFormatter.string(from: date)
    }
    return time
}
