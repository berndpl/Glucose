//
//  Model.swift
//  Snacked
//
//  Created by Bernd Plontsch on 28.06.20.
//

import Combine
import Foundation

public struct Preset:Codable {
    public var title:String
    public let colorLiteral:String
    public var calories:Double
    var id:UUID = UUID()
    
    init(title: String, calories: Double, colorLiteral:String) {
        self.title = title
        self.calories = calories
        self.colorLiteral = colorLiteral
    }
}

extension Preset {
    public var caloriesLabel:String {
        let measurement = Measurement(value: calories, unit: UnitEnergy.calories)
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.numberFormatter.maximumFractionDigits = 0
        return formatter.string(from: measurement)
    }
}

struct Item:Identifiable, Codable, Hashable, Comparable {
    public var glucose:Double
    public var createDate:Date
    var id:UUID = UUID()
    static func < (lhs: Item, rhs: Item) -> Bool {
        return lhs.createDate < rhs.createDate
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
        //insertItems
    }
    
    func insertItems(items:[Item]) {
        self.items.append(contentsOf: items)
    }
    
    public var groupedByDate: [Date: [Item]] {
        Dictionary(grouping: items, by: {Calendar.current.startOfDay(for: $0.createDate)})
    }
    
    public var headers: [Date] {
        groupedByDate.map({ $0.key }).sorted()
    }
    
    @Published var items:[Item] = Storage.loadItems() {
        didSet {
            Storage.saveItems(items: items)
        }
    }
}
