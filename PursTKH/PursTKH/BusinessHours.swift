//
//  BusinessHours.swift
//  PursTKH
//
//  Created by Jared Hubbard on 5/26/24.
//

import Foundation

struct BusinessHours: Codable, Identifiable {
    var id = UUID()
    var dayOfWeek: String
    var startLocalTime: String
    var endLocalTime: String
    
    enum CodingKeys: String, CodingKey {
        case dayOfWeek = "day_of_week"
        case startLocalTime = "start_local_time"
        case endLocalTime = "end_local_time"
    }
}

class BusinessHoursViewModel : ObservableObject {
    @Published var businessHours: [BusinessHours] = []
    
    func fetchBusinessHours() {
        let urlString = "https://purs-demo-bucket-test.s3.us-west-2.amazonaws.com/location.json"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(BusinessHoursResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.businessHours = decodedResponse.hours
                        self.sortAndFormatBusinessHours()
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            } else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown Error")")
            }
        }.resume()
    }
    
    private func sortAndFormatBusinessHours() {
        let daysOfWeek = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"]
        
        self.businessHours = self.businessHours.sorted {
            guard let firstDayIndex = daysOfWeek.firstIndex(of: $0.dayOfWeek),
                  let secondDayIndex = daysOfWeek.firstIndex(of: $1.dayOfWeek) else {
                return false
            }
            if firstDayIndex != secondDayIndex {
                return firstDayIndex < secondDayIndex
            }
            return $0.startLocalTime < $1.startLocalTime
        }.map {businessHour in
            var formattedBusinessHour = businessHour
            formattedBusinessHour.startLocalTime = militaryTo12Converter(businessHour.startLocalTime)
            formattedBusinessHour.endLocalTime = militaryTo12Converter(businessHour.endLocalTime)
            return formattedBusinessHour
        }
    }
}
