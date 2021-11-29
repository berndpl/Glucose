//
//  Model.swift
//  Snacked
//
//  Created by Bernd Plontsch on 28.06.20.
//

import Combine
import Foundation

struct Food:Identifiable, Codable, Hashable {
    public var assetID:String
    public var createDate:Date
    var id:UUID = UUID()
    var timeLabel:String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .none
        timeFormatter.timeStyle = .short
        return timeFormatter.string(from: createDate)
    }
}

struct Item:Identifiable, Codable, Hashable, Comparable {
    public var glucose:Double
    public var createDate:Date
    var id:UUID = UUID()
    static func < (lhs: Item, rhs: Item) -> Bool {
        return lhs.createDate < rhs.createDate
    }
    
    var glucoseLabel:String {
        let glucoseMeasurement = Measurement(value: glucose, unit: UnitConcentrationMass.milligramsPerDeciliter)
        return glucoseMeasurement.description
    }

    var timeLabel:String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .none
        timeFormatter.timeStyle = .short
        return timeFormatter.string(from: createDate)
    }
}

class Model: ObservableObject {
    
    convenience init(items:[Item]) {
        self.init()
        Storage.saveItems(items: items)
    }
    
    public func didReadFile(content: String) {
        let readings = ReaderFreeStyleCSV().read(csvContent: content)
        items = readings.map({ reading in
            Item(glucose: Double(reading.value), createDate: reading.date)
        })
        insertItems(items: items)
    }
    
    public func didTapDeleteAll() {
        items = [Item]()
        foodItems = [Food]()
    }
    
    func insertFood(foodItems:[Food]) {
        self.foodItems.insert(contentsOf: foodItems, at: 0)
        //self.foodItems.append(contentsOf: foodItems)
    }
    
    func insertItems(items:[Item]) {
        //self.items.insert(contentsOf: items, at: 0)
        self.items.append(contentsOf: items)
    }
    
    func lastItem()->String {
        
        let dates = items.map { $0.createDate }
        if dates.count > 0 {
            let mostRecentDate = dates.max(by: {
                $0.timeIntervalSinceReferenceDate < $1.timeIntervalSinceReferenceDate
            })
            
            return mostRecentDate!.short
        } else {
            return "Import CSV to get started"
        }
    }
    
    public func glucoseRating(date:Date)->(label:String, isBad:Bool) {
        
        let calendar = Calendar.current
        let maxDate = calendar.date(byAdding: .minute, value: 60, to: date)
        let filteredItems = items.filter { $0.createDate > date && $0.createDate < maxDate! }
        print("items \(items.count) filtered \(filteredItems.count)")
        
        if filteredItems.count == 0 {
            return ("?", false)
        } else {
            let maxGlucose = filteredItems.max { $0.glucose < $1.glucose }?.glucose
            let isBad = maxGlucose! > 150.0
            return ("\(Int(maxGlucose!))", isBad)
        }
                
    }
    
    public var groupedByDate: [Date: [Item]] {
        Dictionary(grouping: items, by: {Calendar.current.startOfDay(for: $0.createDate)})
    }
    
    public var headers: [Date] {
        groupedByDate.map({ $0.key }).sorted().reversed()
    }
    
    @Published var items:[Item] = Storage.loadItems() {
        didSet {
            Storage.saveItems(items: items)
        }
    }
    
    @Published var foodItems:[Food] = Storage.loadFoodItems() {
        didSet {
            Storage.saveFoodItems(foodItems: foodItems)
        }
    }
}
