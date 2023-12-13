//
//  CounterManager.swift
//  SlackFocus
//
//  Created by Abhineet Bansal on 12/12/2023.
//

import SwiftUI

class CounterManager: ObservableObject {
    static let shared = CounterManager()
    
    static let USER_DATA_COUNTERS_KEY = "countersByDate_v2"
    
    enum CounterType {
        case adhoc, shortTask, focusWork
    }
    
    struct Counters: Codable {
        var adHoc = 0
        var shortTask = 0
        var focusWork = 0
    }
    
    struct CountersByDate: Codable {
        var byDate: [String: Counters] = [:]
    }
    
    var countersByDate: CountersByDate = CountersByDate()
    
    @Published var currentCounters: Counters?
    @Published var currentDate: String?
    
    static func loadCounters() {
        if let savedCounter = UserDefaults.standard.object(forKey: USER_DATA_COUNTERS_KEY) as? Data {
            let decoder = JSONDecoder()
            if let loadedCounters = try? decoder.decode(CountersByDate.self, from: savedCounter) {
                shared.countersByDate = loadedCounters
                print("Loaded: \(shared.countersByDate)")
                
                shared.currentDate = Util.getTodaysDate()
                shared.currentCounters = loadedCounters.byDate[shared.currentDate!] ?? Counters()
            }
        }
    }
    
    static func incrementAndSaveCounter(type: CounterType) {
        updateCurrentCountersIfNeeded()
        
        switch (type) {
        case .adhoc: shared.currentCounters?.adHoc += 1
        case .shortTask: shared.currentCounters?.shortTask += 1
        case .focusWork: shared.currentCounters?.focusWork += 1
        }
        
        shared.countersByDate.byDate[Util.getTodaysDate()] = shared.currentCounters
        print("Saving: \(shared.countersByDate)")

        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(shared.countersByDate) {
            UserDefaults.standard.set(encoded, forKey: USER_DATA_COUNTERS_KEY)
        }
    }
    
    static func getCountersText() -> String {
        updateCurrentCountersIfNeeded()
        
        return "Ad Hoc: \(shared.currentCounters?.adHoc ?? 0). Short: \(shared.currentCounters?.shortTask ?? 0). Focus: \(shared.currentCounters?.focusWork ?? 0)"
    }
    
    static func updateCurrentCountersIfNeeded() {
        if shared.currentDate == Util.getTodaysDate() && shared.currentCounters != nil {
            return
        }
        
        if shared.countersByDate.byDate[Util.getTodaysDate()] == nil {
            shared.countersByDate.byDate[Util.getTodaysDate()] = Counters()
        }
        
        shared.currentDate = Util.getTodaysDate()
        shared.currentCounters = shared.countersByDate.byDate[Util.getTodaysDate()]
    }
}
