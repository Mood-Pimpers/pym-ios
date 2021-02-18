//
//  ExternalEvent.swift
//  Pym
//
//  Created by Manuel Fuchs on 18.02.21.
//

import Foundation

public struct ExternalEvent: Identifiable {
    public let id: UUID
    public let title: String
    public let content: String
}
