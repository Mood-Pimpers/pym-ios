//
//  ActivityList.swift
//  Pym
//
//  Created by Manuel Fuchs on 23.02.21.
//

import SwiftUI

struct DailyJournal: View {
    @Binding var today: Date

    init(of today: Binding<Date>) {
        _today = today
    }

    var body: some View {
        Text("Today is \(today.dateString())")
    }
}

struct ActivityList_Previews: PreviewProvider {
    @State var date = Date()

    static var previews: some View {
        ActivityList(of: $date)
    }
}
