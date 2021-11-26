//
//  FreeStyleCSVReader.swift
//  iOS
//
//  Created by Bernd on 26.11.21.
//

import Foundation

struct Reading:CustomStringConvertible {
    let date:Date
    let value:Int
    var description : String {
        return "[\(date)] \(value)"
    }
}

struct ReaderFreeStyleCSV {
    
    func csv(data: String) -> [[String]] {
        var result: [[String]] = []
        let rows = data.components(separatedBy: "\n")
        for row in rows {
            let columns = row.components(separatedBy: ",")
            result.append(columns)
        }
        return result
    }
    
    public func read(csvContent:String)->[Reading] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm" // 18-11-2021 19:24

        var readings = [Reading]()
        
        let result = csv(data: csvContent)
        let rowsToSkip = 1
        var currentRow = 0
        result.forEach { item in
            if item.count>4 {
                if currentRow > rowsToSkip {
                    let date = dateFormatter.date(from: item[2])!
                    let value = Int(item[4])!
                    readings.append(Reading(date: date, value: value))
                }
            }
            currentRow += 1
        }

        readings.forEach{print($0)}
        return readings
    }
    
}
