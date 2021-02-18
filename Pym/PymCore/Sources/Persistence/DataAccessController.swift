//
//  TrackingContext.swift
//  PymCore
//
//  Created by Manuel Fuchs on 17.02.21.
//

import Foundation

public struct DataAccessController {
    public static let shared = DataAccessController()

    private init() {}

    public func store(entry _: MoodEntry) {}

    public func getEntries(from _: Date, until _: Date) -> [MoodEntry] {
        []
    }
}
