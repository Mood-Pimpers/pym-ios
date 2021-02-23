import SwiftUI

struct DayJournal: View {
    @Binding var today: Date?

    init(of today: Binding<Date?>) {
        _today = today
    }

    var body: some View {
        Text("Today is \(today?.dateString() ?? "unselected")")
    }
}

struct DayJournal_Previews: PreviewProvider {
    @State static var date: Date? = Date()

    static var previews: some View {
        DayJournal(of: $date)
    }
}
