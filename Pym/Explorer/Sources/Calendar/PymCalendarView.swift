import HorizonCalendar
import SwiftUI

struct PymCalendarView: UIViewRepresentable {
    @EnvironmentObject var calendarModel: CalendarModel

    func makeUIView(context _: Context) -> CalendarView {
        let calendar = CalendarView(initialContent: makeContent())
        calendar.backgroundColor = .clear
        calendar.daySelectionHandler = { calendarModel.selectedDay = $0 }
        return calendar
    }

    func updateUIView(_ calendar: CalendarView, context _: Context) {
        calendar.setContent(makeContent())
    }

    private func makeContent() -> CalendarViewContent {
        let calendar = Calendar.current

        let startDate = calendar.date(from: DateComponents(year: 2020, month: 01, day: 01))!
        let endDate = calendar.date(from: DateComponents(year: 2021, month: 12, day: 31))!

        return CalendarViewContent(
            calendar: calendar,
            visibleDateRange: startDate ... endDate,
            monthsLayout: .horizontal(options: HorizontalMonthsLayoutOptions())
        ).withDayItemModelProvider { day in
            var properties = DayLabel.InvariantViewProperties(
                font: UIFont.systemFont(ofSize: 18),
                textColor: .darkGray,
                backgroundColor: .clear
            )

            if day == calendarModel.selectedDay {
                properties.textColor = .red
            } else if day.day % 2 == 0 {
                properties.textColor = .gray
            } else {
                properties.textColor = .black
            }

            return CalendarItemModel<DayLabel>(
                invariantViewProperties: properties,
                viewModel: .init(day: day)
            )
        }
        .withMonthHeaderItemModelProvider { (month) -> AnyCalendarItemModel in
            CalendarItemModel<MonthHeader>(
                invariantViewProperties: .init(font: UIFont.systemFont(ofSize: 12.0),
                                               textColor: .blue,
                                               backgroundColor: .clear),
                viewModel: .init(month: month)
            )
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static let model = CalendarModel()

    static var previews: some View {
        PymCalendarView()
            .environmentObject(model)
    }
}
