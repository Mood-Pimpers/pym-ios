import XCTest
@testable import Insights
import PymCore

class MoodCorrelationServiceTests: XCTestCase {

    func testCalculateCorrelations() throws {
        let day1 = Date().adding(.day, value: -2).beginning(of: .day)!
        let day2 = Date().adding(.day, value: -1).beginning(of: .day)!
        let day3 = Date().beginning(of: .day)

        let moodEntries = [
            MoodEntry(date: Date().add, rating: <#T##MoodRating#>, feelings: <#T##Set<Feeling>#>, activities: <#T##Set<Activity>#>)
        ]

        let events = [
            ExternalEvent(
        ]
    }
}
