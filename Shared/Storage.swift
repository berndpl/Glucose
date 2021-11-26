//
//  Storage.swift
//  Tracker Kit
//
//  Created by Bernd Plontsch on 06.05.20.
//  Copyright © 2020 Bernd Plontsch. All rights reserved.
//

import Foundation

struct key {
    static let appGroup = "group.de.plontsch.food-tracker.shared"
    static let itemsFileName = "items.json"
    static let presetsFileName = "presets.json"
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
    
    class func savePresets(presets: [Preset]) {
        // Encode
        let jsonEncoder = JSONEncoder()
        guard let jsonData = try? jsonEncoder.encode(presets) else {
            fatalError("Error Encode JSON")
        }
        let jsonString = String(data: jsonData, encoding: .utf8)

        // Save
        do {
            try jsonString?.write(to: Storage.filePath(filename: key.presetsFileName), atomically: false, encoding: .utf8)
            print("Saved \(presets)")
        }
        catch { fatalError("Error Writing File") }
    }
        
    class func loadItems()->[Item] {
        if let items = loadItems() {
            return items
        }
        return [Item]()
    }

    class func loadPresets()->[Preset] {
        if let presets = loadPresets() {
            return presets
        }
        return defaultPresets()
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
    
    class func loadPresets()->[Preset]? {
        // Read
        do {
            print("Load from \(filePath(filename: key.presetsFileName))")
            let data = try Data(contentsOf: filePath(filename: key.presetsFileName), options: .mappedIfSafe)
            let jsonDecoder = JSONDecoder()
            guard let state = try? jsonDecoder.decode([Preset].self, from: data) else {
                print("Error decoding")
                return nil
            }
            return state
        }
        catch { print("No Presets File Loaded") }
            
        return nil
    }
        
}
