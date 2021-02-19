//
//  ExtDataAccessController.swift
//  Pym
//
//  Created by Manuel Fuchs on 19.02.21.
//

import Foundation

public struct ExtDataAccessController {
    public static let shared = ExtDataAccessController()
    private let sources: [ExternalDataSource]

    private init() {
        sources = [
            FakeHealthKitDataSource()
        ]
    }

    public func getEvents(from startDate: Date, until endDate: Date) -> [ExternalEvent] {
        sources.flatMap { $0.getEvents(from: startDate, until: endDate) }
    }
}
