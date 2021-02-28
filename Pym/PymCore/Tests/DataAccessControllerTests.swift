@testable import PymCore
import XCTest

extension MoodEntry: Equatable {
    public static func == (lhs: MoodEntry, rhs: MoodEntry) -> Bool {
        lhs.id == rhs.id
            && lhs.timestamp.era == rhs.timestamp.era
            && lhs.timestamp.year == rhs.timestamp.year
            && lhs.timestamp.month == rhs.timestamp.month
            && lhs.timestamp.day == rhs.timestamp.day
            && lhs.timestamp.hour == rhs.timestamp.hour
            && lhs.timestamp.minute == rhs.timestamp.minute
            && lhs.activities == rhs.activities
            && lhs.feelings == rhs.feelings
            && lhs.rating == rhs.rating
    }
}

class DataAccessControllerTests: XCTestCase {
    override func setUpWithError() throws {
        DataAccessController.persistenceController = PersistenceController.preview
    }

    override func tearDownWithError() throws {
        DataAccessController.shared.deleteAllEntries()
    }

    func testStoreEntryTest() throws {
        let exptectedEntry = MoodEntry(date: Date(), rating: .bad, feelings: [.angry, .confused], activities: ["tennis", "programming", "work"])
        DataAccessController.shared.store(entry: exptectedEntry)

        let actualEntries = DataAccessController.shared.getEntries(from: Date() - 10 * 60, until: Date() + 10 * 60)
        XCTAssertEqual(1, actualEntries.count)

        let actualEntry = actualEntries.first
        XCTAssertNotNil(actualEntry)
        XCTAssertEqual(exptectedEntry.activities.sorted(), actualEntry?.activities.sorted())
        XCTAssertEqual(exptectedEntry.timestamp, actualEntry?.timestamp)
        XCTAssertEqual(exptectedEntry.feelings.sorted(), actualEntry?.feelings.sorted())
        XCTAssertEqual(exptectedEntry.id, actualEntry?.id)
        XCTAssertEqual(exptectedEntry.rating, actualEntry?.rating)
    }

    func testGetEarliestEntryDate() throws {
        let boundary = 10
        for index in 1 ... boundary {
            let date = Date().adding(.month, value: -index)
            DataAccessController.shared.store(entry: MoodEntry(date: date, rating: MoodRating.allCases.randomElement()!, feelings: Set<Feeling>(), activities: Set<Activity>()))
        }

        let expectedEarliestDate = Date().adding(.month, value: -boundary)

        let earliestEntry = DataAccessController.shared.getEarliestEntry()
        XCTAssertNotNil(earliestEntry)

        let actualEarliestDate = earliestEntry!.timestamp
        XCTAssertEqual(expectedEarliestDate.era, actualEarliestDate.era)
        XCTAssertEqual(expectedEarliestDate.year, actualEarliestDate.year)
        XCTAssertEqual(expectedEarliestDate.month, actualEarliestDate.month)
        XCTAssertEqual(expectedEarliestDate.day, actualEarliestDate.day)
    }

    func testGetEntriesByDay() throws {
        let entry1 = MoodEntry(date: Date().adding(.day, value: -1), rating: .good, feelings: [.amazed, .curious], activities: ["University"])
        let entry2 = MoodEntry(date: Date().adding(.minute, value: -30), rating: .moderate, feelings: [.confused], activities: ["Work"])
        let entry3 = MoodEntry(date: Date(), rating: .good, feelings: [.angry, .distressed], activities: ["Work"])
        let entry4 = MoodEntry(date: Date().adding(.day, value: 1), rating: .good, feelings: [.amazed, .enthusiastic, .happy], activities: ["Sport"])

        for entry in [entry1, entry2, entry3, entry4] {
            DataAccessController.shared.store(entry: entry)
        }

        let today = Date()
        let entriesToday = DataAccessController.shared.getEntries(fromDay: today)

        XCTAssertEqual(2, entriesToday.count)

        let actualFirstEntry = entriesToday.filter { $0.id == entry2.id }.first
        let actualSecondEntry = entriesToday.filter { $0.id == entry3.id }.first
        XCTAssertEqual(entry2, actualFirstEntry)
        XCTAssertEqual(entry3, actualSecondEntry)
    }
}
