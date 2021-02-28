import HorizonCalendar
import UIKit

struct MonthHeader: CalendarItemViewRepresentable {
    /// Properties that are set once when we initialize the view.
    struct InvariantViewProperties: Hashable {}

    /// Properties that will vary depending on the particular date being displayed.
    struct ViewModel: Equatable {
        let month: Month
    }

    static func makeView(withInvariantViewProperties _: InvariantViewProperties) -> UILabel {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 25)
        label.textColor = .black
        label.textAlignment = .left
        label.clipsToBounds = true
        return label
    }

    static func setViewModel(_ viewModel: ViewModel, on view: UILabel) {
        let monthDateComponents = viewModel.month.components
        let monthDate = Calendar.current.date(from: monthDateComponents)!

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        let monthAndYearText = dateFormatter.string(from: monthDate)

        view.text = monthAndYearText
    }
}

extension CalendarViewContent {
    func addPymMonthHeaderStyle() -> CalendarViewContent {
        withMonthHeaderItemModelProvider {
            CalendarItemModel<MonthHeader>(invariantViewProperties: .init(), viewModel: .init(month: $0))
        }
    }
}
