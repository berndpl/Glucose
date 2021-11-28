//
//  Storage.swift
//  Tracker Kit
//
//  Created by Bernd Plontsch on 06.05.20.
//  Copyright © 2020 Bernd Plontsch. All rights reserved.
//

import Foundation

struct key {
    static let appGroup = "group.de.plontsch.glucose.shared"
    static let itemsFileName = "items.json"
    static let foodItemsFileName = "foodItems.json"
}

public class Storage {
    
    class func filePath(filename:String)->URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        let filePath = documentsDirectory.appendingPathComponent(filename)
        return filePath
    }
    
    class func resetItems() {
        saveItems(items: [])
    }
    
    class func saveItems(items: [Item]) {
        // Encode
        let jsonEncoder = JSONEncoder()
        guard let jsonData = try? jsonEncoder.encode(items) else {
            fatalError("Error Encode JSON")
        }
        let jsonString = String(data: jsonData, encoding: .utf8)

        // Save
        do {
            try jsonString?.write(to: Storage.filePath(filename: key.itemsFileName), atomically: false, encoding: .utf8)
            print("Saved \(items)")
        }
        catch { fatalError("Error Writing File") }
    }
    
    class func loadItems()->[Item] {
        if let items = loadItems() {
            return items
        }
        return [Item]()
    }

    class func loadItems()->[Item]? {
        // Read
        do {
            print("Load from \(filePath(filename: key.itemsFileName))")
            let data = try Data(contentsOf: filePath(filename: key.itemsFileName), options: .mappedIfSafe)
            let jsonDecoder = JSONDecoder()
            guard let state = try? jsonDecoder.decode([Item].self, from: data) else {
                print("Error decoding")
                return nil
            }
            return state
        }
        catch { print("No Items File Loaded") }
            
        return nil
    }
 
    // FOOD
    
    class func resetFoodItems() {
        saveFoodItems(foodItems: [])
    }
    
    class func saveFoodItems(foodItems: [Food]) {
        // Encode
        let jsonEncoder = JSONEncoder()
        guard let jsonData = try? jsonEncoder.encode(foodItems) else {
            fatalError("Error Encode JSON")
        }
        let jsonString = String(data: jsonData, encoding: .utf8)

        // Save
        do {
            try jsonString?.write(to: Storage.filePath(filename: key.foodItemsFileName), atomically: false, encoding: .utf8)
            print("Saved \(foodItems)")
        }
        catch { fatalError("Error Writing File") }
    }
    
    class func loadFoodItems()->[Food] {
        if let items = loadFoodItems() {
            return items
        }
        return [Food]()
    }

    class func loadFoodItems()->[Food]? {
        // Read
        do {
            print("Load from \(filePath(filename: key.foodItemsFileName))")
            let data = try Data(contentsOf: filePath(filename: key.foodItemsFileName), options: .mappedIfSafe)
            let jsonDecoder = JSONDecoder()
            guard let state = try? jsonDecoder.decode([Food].self, from: data) else {
                print("Error decoding")
                return nil
            }
            return state
        }
        catch { print("No Items File Loaded") }
            
        return nil
    }
    
}
