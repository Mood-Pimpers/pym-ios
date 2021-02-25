//
//  CalendarBackgroundLayer.swift
//  Explorer
//
//  Created by Manuel Fuchs on 25.02.21.
//

import SwiftUI

struct CalendarBackgroundLayer: View {
    var body: some View {
        Rectangle()
            .foregroundColor(Color.primaryColor)
            .cornerRadius(25, corners: [.bottomLeft, .bottomRight])
    }
}

struct CalendarBackgroundLayer_Previews: PreviewProvider {
    static var previews: some View {
        CalendarBackgroundLayer()
    }
}
