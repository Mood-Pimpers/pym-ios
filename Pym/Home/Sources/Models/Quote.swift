//
//  Quote.swift
//  Home
//
//  Created by Daniel Bauer on 21.12.20.
//

import Foundation

public struct Quote: Identifiable {
    public let id: Int
    let text: String
    let author: String
    let url: (_ width: Int, _ heigth: Int) -> URL
}
