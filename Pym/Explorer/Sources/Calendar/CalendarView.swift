import HorizonCalendar
import PymCore
import SwiftUI

struct PymCalendarView: UIViewRepresentable {
    @EnvironmentObject var viewModel: ExplorerViewModel

    func makeUIView(context _: Context) -> UIView {
        let calendarView = CalendarView(initialContent: makeContent())
        calendarView.backgroundColor = .clear
        calendarView.daySelectionHandler = { viewModel.selectedDay = $0 }

        calendarView.layoutMargins = .zero
        calendarView.translatesAutoresizingMaskIntoConstraints = false

        let viewParent = UIView()
        viewParent.layoutMargins = .zero
        viewParent.addSubview(calendarView)

        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(equalTo: viewParent.layoutMarginsGuide.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: viewParent.layoutMarginsGuide.trailingAnchor),
            calendarView.topAnchor.constraint(equalTo: viewParent.layoutMarginsGuide.topAnchor),
            calendarView.bottomAnchor.constraint(equalTo: viewParent.layoutMarginsGuide.bottomAnchor)
        ])

        return viewParent
    }

    func updateUIView(_ viewParent: UIView, context _: Context) {
        if let calendar = viewParent.subviews.first as? CalendarView {
            calendar.setContent(makeContent())
        }
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
        .withVerticalDayMargin(15)
        .withHorizontalDayMargin(15)
    }
}

struct CalendarView_Previews: PreviewProvider {
    static let model = ExplorerViewModel()

    static var previews: some View {
        PymCalendarView()
            .environmentObject(model)
    }
}
