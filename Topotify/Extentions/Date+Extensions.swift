//
//  Date+Extensions.swift
//  Topotify
//
//  Created by Usama Fouad on 22/12/2022.
//

import Foundation

extension Date {
    func getFormmatedTime(withA: Bool=false) -> String {
        let dateFormmater = DateFormatter()
        dateFormmater.dateFormat = "hh : mm \(withA ? "a" : "")"
        dateFormmater.locale = Locale(identifier: "en_us")
        
        return dateFormmater.string(from: self)
    }
    
    func getFormmatedDate() -> String {
        let dateFormmater = DateFormatter()
        dateFormmater.dateFormat = "EEEE, d MMMM"
        dateFormmater.locale = Locale(identifier: "en_us")
        
        return dateFormmater.string(from: self)
    }
    
    func getRemaingTimeFromNow() -> TimeInterval {
        if self > Date() {
            return self.timeIntervalSinceNow
        } else {
            return self.addingTimeInterval(24 * 60 * 60).timeIntervalSinceNow
        }
    }
    
    func getFormattedRemainingTimeFromNow() -> String {
        let remaingTime = getRemaingTimeFromNow()
        let hours = Int(remaingTime / 3600)
        let minutes = Int(remaingTime / 60) % 60
        let seconds = Int(remaingTime) % 60
                
        if hours > 0 {
            return String(format: "%.2ih %.2im", hours, minutes)
        } else if minutes > 0 {
            return String(format: "%.2im %.2is", minutes, seconds)
        }
        
        return String(format: "%.2is", seconds)
    }
    
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
    
    func computeNewDate(from fromDate: Date, to toDate: Date) -> Date {
         let delta = toDate - fromDate // `Date` - `Date` = `TimeInterval`
         let today = Date()
         if delta < 0 {
             return today
         } else {
             return today + delta // `Date` + `TimeInterval` = `Date`
         }
    }

}
