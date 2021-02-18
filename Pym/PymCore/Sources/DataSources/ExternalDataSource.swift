//
//  ExternalDataSource.swift
//  Pym
//
//  Created by Manuel Fuchs on 18.02.21.
//

import Foundation

public protocol ExternalDataSource {
    var sourceName: String { get }

    func getEvents(from _: Date, until _: Date) -> [ExternalEvent]
}
