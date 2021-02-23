import HorizonCalendar
import UIKit

struct MonthHeader: CalendarItemViewRepresentable {
    /// Properties that are set once when we initialize the view.
    struct InvariantViewProperties: Hashable {
        let font: UIFont
        var textColor: UIColor
        let backgroundColor: UIColor
    }

    /// Properties that will vary depending on the particular date being displayed.
    struct ViewModel: Equatable {
        let month: Month
    }

    static func makeView(withInvariantViewProperties invariantViewProperties: InvariantViewProperties) -> UILabel {
        let label = UILabel()

        label.backgroundColor = invariantViewProperties.backgroundColor
        label.font = invariantViewProperties.font
        label.textColor = invariantViewProperties.textColor

        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 12
        label.layer.borderColor = CGColor(red: 100, green: 0, blue: 0, alpha: 100)

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
