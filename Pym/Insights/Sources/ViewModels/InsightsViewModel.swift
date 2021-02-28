import PymCore
import SwiftUI

class InsightsViewModel: ObservableObject {
    private let dateFormatter = DateFormatter()
    private let calendar = Calendar.current
    private let dataController = DataAccessController.shared
    private var currentDate = Date()
    private var startWeekDate = Date()
    private var endWeekDate = Date()

    @Published var formattedStartWeekDate = ""
    @Published var formattedEndWeekDate = ""
    @Published var dateTitle = ""
    @Published var nextWeekDisabled = true
    @Published var lastWeekMoodEntries = [Double]()
    @Published var currentWeekMoodEntries = [Double]()
    @Published var moodPercentage = 5.5

    init() {
        dateFormatter.dateFormat = "dd. MMM"
        currentDate = currentDate.beginning(of: .day)!
        calculateDates()
    }

    func previousWeek() {
        currentDate = currentDate.lastWeek()
        calculateDates()
        nextWeekDisabled = false
    }

    func nextWeek() {
        currentDate = currentDate.nextWeek()
        calculateDates()
    }

    func calculateDates() {
        startWeekDate = currentDate.beginning(of: .weekOfMonth)!
        endWeekDate = currentDate.end(of: .weekOfMonth)!
        formattedStartWeekDate = dateFormatter.string(from: startWeekDate)
        formattedEndWeekDate = dateFormatter.string(from: endWeekDate)

        lastWeekMoodEntries = moodValues(from: startWeekDate.lastWeek(), until: endWeekDate.lastWeek())
        currentWeekMoodEntries = moodValues(from: startWeekDate, until: endWeekDate)
        moodPercentage = calculateMoodTrend(for: lastWeekMoodEntries, and: currentWeekMoodEntries)

        if calendar.isDate(currentDate, inSameDayAs: Date()) {
            nextWeekDisabled = true
            dateTitle = "Current week"
        } else if calendar.isDate(currentDate, inSameDayAs: Date().lastWeek()) {
            dateTitle = "Last week"
        } else {
            dateTitle = "CW\(currentDate.weekOfYear)"
        }
    }

    private func calculateMoodTrend(for lastEntries: [Double], and currentEntries: [Double]) -> Double {
        if lastEntries.isEmpty || currentEntries.isEmpty {
            return 0.0
        }

        let lastAverage = lastEntries.average()
        return (currentEntries.average() - lastAverage) / lastAverage * 100
    }

    private func moodValues(from: Date, until: Date) -> [Double] {
        Dictionary(grouping: dataController.getEntries(from: from, until: until)) { $0.timestamp.beginning(of: .day)! }.flatMap { (_: Date, entries: [MoodEntry]) -> [Double] in
            // if more than two entries per day exist -> calculate the average for the last entries
            if entries.count > 2 {
                return [Double(entries[0].rating.rawValue), entries.dropFirst().map { entry in Double(entry.rating.rawValue)
                }.average()]
            }

            return entries.map { (entry: MoodEntry) -> Double in
                Double(entry.rating.rawValue)
            }
        }
    }
}
