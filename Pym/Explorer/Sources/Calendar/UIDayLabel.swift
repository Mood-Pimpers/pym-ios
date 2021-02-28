import HorizonCalendar
import PymCore
import UIKit

struct DayLabel: CalendarItemViewRepresentable {
    /// Properties that are set once when we initialize the view.
    struct InvariantViewProperties: Hashable {
        let isSelected: Bool
        let meanRating: Double?
    }

    /// Properties that will vary depending on the particular date being displayed.
    struct ViewModel: Equatable {
        let day: Day
    }

    static func makeView(withInvariantViewProperties invariantViewProperties: InvariantViewProperties) -> UILabel {
        let label = UILabel()

        if let meanRating = invariantViewProperties.meanRating {
            label.font = UIFont.systemFont(ofSize: 18, weight: invariantViewProperties.isSelected ? .bold : .regular)

            if meanRating < 3 {
                label.backgroundColor = UIColor(.chartNegativeColor)
            } else {
                label.backgroundColor = UIColor(.chartPositiveColor)
            }
        } else {
            // nothing tracked on this day
            label.font = UIFont.systemFont(ofSize: 18)
            label.textColor = .white
            label.backgroundColor = .clear
        }

        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 20
        label.layer.borderColor = .none

        return label
    }

    static func setViewModel(_ viewModel: ViewModel, on view: UILabel) {
        view.text = "\(viewModel.day.day)"
    }
}

extension CalendarViewContent {
    func addPymDayStyle(_ model: ExplorerViewModel) -> CalendarViewContent {
        withDayItemModelProvider { day in
            let ratings = model.getMoodRatingsFor(day: day.date)

            let meanRating: Double?
            if ratings.count > 0 {
                let ratingsSum = ratings
                    .map { Int($0.rawValue) }
                    .reduce(0, +)
                meanRating = Double(ratingsSum) / Double(ratings.count)
            } else {
                meanRating = nil
            }

            return CalendarItemModel<DayLabel>(
                invariantViewProperties: DayLabel.InvariantViewProperties(
                    isSelected: day == model.selectedDay,
                    meanRating: meanRating
                ),
                viewModel: .init(day: day)
            )
        }
    }
}
