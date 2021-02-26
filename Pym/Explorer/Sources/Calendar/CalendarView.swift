import HorizonCalendar
import PymCore
import SwiftUI

struct PymCalendarView: UIViewRepresentable {
    @EnvironmentObject var viewModel: CalendarViewModel

    func makeUIView(context _: Context) -> CalendarView {
        let calendar = CalendarView(initialContent: makeContent())
        calendar.backgroundColor = .clear
        calendar.daySelectionHandler = { viewModel.selectedDay = $0 }
        return calendar
    }

    func updateUIView(_ calendar: CalendarView, context _: Context) {
        calendar.setContent(makeContent())
    }

    private func makeContent() -> CalendarViewContent {
        let calendar = Calendar.current

        return CalendarViewContent(
            calendar: calendar,
            visibleDateRange: viewModel.calendarStartDate ... viewModel.calendarEndDate,
            monthsLayout: .horizontal(options: HorizontalMonthsLayoutOptions())
        )
        .addPymDayStyle(viewModel)
        .addPymMonthHeaderStyle()
    }
}

struct CalendarView_Previews: PreviewProvider {
    static let model = CalendarViewModel()

    static var previews: some View {
        PymCalendarView()
            .environmentObject(model)
    }
}
