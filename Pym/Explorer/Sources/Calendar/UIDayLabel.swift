import HorizonCalendar
import UIKit

struct DayLabel: CalendarItemViewRepresentable {
    /// Properties that are set once when we initialize the view.
    struct InvariantViewProperties: Hashable {
        let font: UIFont
        var textColor: UIColor
        let backgroundColor: UIColor
    }

    /// Properties that will vary depending on the particular date being displayed.
    struct ViewModel: Equatable {
        let day: Day
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
        view.text = "\(viewModel.day.day)"
    }
}

extension CalendarViewContent {
    func addPymDayStyle(_ model: CalendarViewModel) -> CalendarViewContent {
        withDayItemModelProvider { day in
            var properties = DayLabel.InvariantViewProperties(
                font: UIFont.systemFont(ofSize: 18),
                textColor: .darkGray,
                backgroundColor: .clear
            )

            if day == model.selectedDay {
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
    }
}
