@testable import Insights
import PymCore
import XCTest

class MoodCorrelationServiceTests: XCTestCase {
    func testCalculateCorrelations() throws {
        let activity1 = "Activity 1"
        let activity2 = "Activity 2"
        let activity3 = "Activity 3"
        let activity4 = "Activity 4"
        let activity5 = "Activity 5"

        let day1 = Date().adding(.day, value: -2).beginning(of: .day)!
        let day2 = Date().adding(.day, value: -1).beginning(of: .day)!
        let day3 = Date().beginning(of: .day)!

        let moodEntries: [MoodEntry] = [
            // day1 entries -> none

            // day2 entries
            MoodEntry(date: day2.adding(.hour, value: 10), rating: .good, feelings: [], activities: [activity5]),
            MoodEntry(date: day2.adding(.hour, value: 18), rating: .poor, feelings: [], activities: []),

            // day3 entries
            MoodEntry(date: day3.adding(.hour, value: 17).adding(.second, value: 21), rating: .great, feelings: [], activities: [activity3, activity4])
        ]

        let events: [ExternalEvent] = [
            // day1 activities
            ExternalEvent(title: activity1, at: day1.adding(.hour, value: 9), from: .healthKit, with: "content"),
            ExternalEvent(title: activity2, at: day1.adding(.hour, value: 15), from: .healthKit, with: "content"),

            // day2 activities
            ExternalEvent(title: activity3, at: day2.adding(.hour, value: 11).adding(.minute, value: 15), from: .healthKit, with: "content"),
            ExternalEvent(title: activity4, at: day2.adding(.hour, value: 16), from: .healthKit, with: "content"),
            ExternalEvent(title: activity3, at: day2.adding(.hour, value: 20), from: .healthKit, with: "content"),

            // day3 activities
            ExternalEvent(title: activity5, at: day3.adding(.hour, value: 5).adding(.second, value: 39), from: .healthKit, with: "content"),
            ExternalEvent(title: activity5, at: day3.adding(.hour, value: 23).adding(.second, value: 17), from: .healthKit, with: "content")
        ]

        let expectedActivity3Correlation = 0.33333
        let expectedActivity4Correlation = 0.25
        let expectedActivity5Correlation = 0.83333

        let correlations = MoodCorrelationService.shared.calculateCorrelations(of: moodEntries, with: events)

        XCTAssertEqual(3, correlations.count)

        if let actualActivity3Correlation = correlations[activity3] {
            XCTAssertEqual(expectedActivity3Correlation, actualActivity3Correlation, accuracy: 0.001)
        } else {
            XCTAssertTrue(false)
        }

        if let actualActivity4Correlation = correlations[activity4] {
            XCTAssertEqual(expectedActivity4Correlation, actualActivity4Correlation, accuracy: 0.001)
        } else {
            XCTAssertTrue(false)
        }

        if let actualActivity5Correlation = correlations[activity5] {
            XCTAssertEqual(expectedActivity5Correlation, actualActivity5Correlation, accuracy: 0.001)
        } else {
            XCTAssertTrue(false)
        }
    }
}
