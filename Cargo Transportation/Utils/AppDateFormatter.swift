//
//  AppDateFormatter.swift
//  Cargo Transportation
//
//  Created by Alex Bezkopylnyi on 01.12.2020.
//

import Foundation

struct AppDateFormatter {

    var locale: Locale {
        return Locale.current
    }
    
    private let dateFormatter : DateFormatter
    
    private let fullDateFormat = "yyyy-MM-dd'T'HH:mm:SS'Z'"
    private let defaultTimeZone = TimeZone(identifier: "GMT")
    
    init() {
        
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fullDateFormat
        dateFormatter.timeZone = defaultTimeZone
    }
    
    func date(from dateString: String) -> Date? {
        let date = dateFormatter.date(from: dateString)
        return date
    }
    
    func shortDateString(date: Date) -> String {
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    func minutesLeft(toDate date: Date)->Int?{
        let localDate = Date()
        //print(dateFormatter.string(from: localDate))
        let localDateString = dateFormatter.string(from: localDate)
        let currentDate = dateFormatter.date(from: localDateString) ?? Date()
        let diff = Calendar.current.dateComponents([.minute], from: currentDate, to: date).minute
        return diff
    }
    
    func getLocalFormattedTime(time: String?)->String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fullDateFormat
        dateFormatter.timeZone = TimeZone(identifier: "GMT")
        let date = dateFormatter.date(from: time ?? "Some date")
        
        let newFormat = "HH:mm"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = newFormat
        let newTime = dateFormatter.string(from: date ?? Date())
        return newTime
    }
    
}
