//
//  Date+Extension.swift
//  iOS
//
//  Created by Bernd on 29.11.21.
//

import Foundation

extension Date {
    var short:String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        dateFormatter.doesRelativeDateFormatting = true
        
        return dateFormatter.string(from: self)
    }

    var shortRelativeWithTime:String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        dateFormatter.doesRelativeDateFormatting = true
        
        return dateFormatter.string(from: self)
    }

    var shortRelative:String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.doesRelativeDateFormatting = true
        
        return dateFormatter.string(from: self)
    }

}
